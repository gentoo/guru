# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit desktop java-pkg-2 xdg

DESCRIPTION="Tool for building production chains for modded minecraft"
HOMEPAGE="https://github.com/bigbass1997/NotEnoughProduction"
SRC_URI="
	https://github.com/bigbass1997/${PN}/releases/download/v${PV}/${P}.zip
	https://raw.githubusercontent.com/bigbass1997/${PN}/master/lwjgl3/src/main/resources/libgdx128.png -> ${PN}-128.png
	https://raw.githubusercontent.com/bigbass1997/${PN}/master/lwjgl3/src/main/resources/libgdx64.png -> ${PN}-64.png
	https://raw.githubusercontent.com/bigbass1997/${PN}/master/lwjgl3/src/main/resources/libgdx32.png -> ${PN}-32.png
	https://raw.githubusercontent.com/bigbass1997/${PN}/master/lwjgl3/src/main/resources/libgdx16.png -> ${PN}-16.png
"

S="${WORKDIR}"

LICENSE="CC-BY-NC-SA-4.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="virtual/jre:1.8"
BDEPEND="app-arch/unzip"

src_unpack() {
	default
	cp "${DISTDIR}/${PN}"-{16,32,64,128}.png "${S}" || die
}

src_install() {
	java-pkg_newjar "${WORKDIR}/${P}.jar" "${PN}.jar"

	dobin "${FILESDIR}/${PN}"

	newicon -s 128x128 "${PN}-128.png" nep.png
	newicon -s 64x64 "${PN}-64.png" nep.png
	newicon -s 32x32 "${PN}-32.png" nep.png
	newicon -s 16x16 "${PN}-16.png" nep.png
	make_desktop_entry "${PN}" "Not Enough Production" nep Utility
}
