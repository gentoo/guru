# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake fcaps

MY_PV="${PV/_/-}"

DESCRIPTION="XMPP gateway to IRC"
HOMEPAGE="https://biboumi.louiz.org/"
SRC_URI="https://git.louiz.org/biboumi/snapshot/biboumi-${MY_PV}.tar.xz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+idn logrotate postgres +sqlite +ssl systemd udns"

DEPEND="
	dev-libs/expat
	virtual/libiconv
	sys-apps/util-linux
	sqlite? ( dev-db/sqlite )
	postgres? ( dev-db/postgresql:* )
	idn? ( net-dns/libidn )
	udns? ( net-libs/udns )
	ssl? ( dev-libs/botan:2 )
	!ssl? ( dev-libs/libgcrypt )
	systemd? ( sys-apps/systemd )
"
BDEPEND="dev-python/sphinx"
RDEPEND="
	${DEPEND}
	acct-user/biboumi
"

S="${WORKDIR}/${PN}-${MY_PV}"

DOCS=( README.rst CHANGELOG.rst doc/user.rst )

# Allow biboumi to run an identd on port 113.
FILECAPS=( -m 755 cap_net_bind_service+ep usr/bin/biboumi )

src_prepare() {
	cmake_src_prepare

	if ! use systemd; then		# Don't install biboumi.service.
		sed -i '/DESTINATION lib\/systemd\/system/d' CMakeLists.txt || die
	fi
}

src_configure() {
	local mycmakeargs=(
		-DWITH_BOTAN="$(usex ssl)"
		-DWITH_LIBIDN="$(usex idn)"
		-DWITH_SYSTEMD="$(usex systemd)"
		-DWITH_UDNS="$(usex udns)"
		-DWITH_SQLITE3="$(usex sqlite)"
		-DWITH_POSTGRESQL="$(usex postgres)"

		-DWITHOUT_SYSTEMD="$(usex systemd no yes)"
		-DWITHOUT_POSTGRESQL="$(usex postgres no yes)"
	)							# The WITHOUT_* is really needed.

	cmake_src_configure
}

src_compile() {
	cmake_src_compile

	cmake_build man
}

src_install() {
	cmake_src_install

	if ! use systemd; then
		newinitd "${FILESDIR}/${PN}.initd" "${PN}"
	fi

	if use logrotate; then
		insinto etc/logrotate.d
		if use systemd; then
			newins "${FILESDIR}/${PN}.logrotate.systemd" "${PN}"
		else
			newins "${FILESDIR}/${PN}.logrotate.openrc" "${PN}"
		fi
	fi

	diropts --owner=biboumi --group=biboumi --mode=750
	if use sqlite; then
		keepdir var/lib/biboumi
	fi
	keepdir var/log/biboumi

	insinto etc/biboumi
	insopts --group=biboumi --mode=640
	newins conf/biboumi.cfg biboumi.cfg.example
}
