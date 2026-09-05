# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="CLI utility for the kobweb web framework"
HOMEPAGE="https://kobweb.varabyte.com"
SRC_URI="https://github.com/varabyte/kobweb-cli/releases/download/v${PV}/kobweb-${PV}.tar -> ${P}.tar"

S="${WORKDIR}/kobweb-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-lang/kotlin-bin"
RDEPEND="${DEPEND}"

src_prepare() {
	default

	# update classpath to use the java filesystem layout
	sed -i \
		-e "s/CLASSPATH=\\\$APP_HOME\\/lib\\/kobweb-${PV}-all.jar/CLASSPATH=\\\$APP_HOME\\/..\\/opt\\/${PN}\\/lib\\/kobweb-${PV}-all.jar/g" \
		bin/kobweb || die "Sed failed"
}

src_install() {
	dobin bin/kobweb

	mkdir "${ED}/opt/${PN}/lib" -p || die "Couldn't make destination directory"
	cp "lib/kobweb-${PV}-all.jar" "${ED}/opt/${PN}/lib/kobweb-${PV}-all.jar" \
		|| die "Couldn't install to destination directory"
}
