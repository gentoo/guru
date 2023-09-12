# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd

DESCRIPTION="an API for interacting with Signal Private Messenger"
HOMEPAGE="https://gitlab.com/signald/signald"
SRC_URI="https://gitlab.com/signald/signald/-/archive/${PV}.tar.bz2 -> ${P}.tar.bz2
	https://jroy.ca/dist/${P}.tar.xz
"
COMMIT="8cfebfe0ab8395221eca94c4c366abb6d7f39314"
S="${WORKDIR}/${P}-${COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="acct-user/signald
	virtual/jre"
DEPEND="${RDEPEND}"
BDEPEND="dev-java/gradle-bin:7.3.3"

# From https://github.com/gentoo/gentoo/pull/28986
# TODO: inherit this eclass when the PR is merged
GRADLE_ARGS=(
	--console=plain
	--gradle-user-home "${T}/gradle_user_home"
	--info
	--no-build-cache
	--no-daemon
	--offline
	--parallel
	--project-cache-dir "${T}/gradle_project_cache"
	--stacktrace
)

src_unpack() {
	default
	mv "${WORKDIR}/gradle_project_cache" "${T}" || die
	mv "${WORKDIR}/gradle_user_home" "${T}" || die
}

src_compile() {
	gradle "${GRADLE_ARGS[@]}" installDist || die
}

src_install() {
	rm "${S}/build/install/signald/bin/signald.bat" || die
	dodir "/var/lib"
	mv "${S}/build/install/signald" "${ED}/var/lib" || die
	dosym -r "/var/lib/signald/bin/signald" "usr/bin/${PN}"

	newinitd "${FILESDIR}/${PN}.initd" "${PN}"
	sed -i -e "s/^EnvironmentFile=-\/etc\/default\/signald$//" \
		"${S}/src/main/resources/io/finn/signald/signald.service" || die
	sed -i -e "s/--system-socket/-s \/tmp\/signald.sock/" \
		"${S}/src/main/resources/io/finn/signald/signald.service" || die
	systemd_dounit "${S}/src/main/resources/io/finn/signald/signald.service"
}
