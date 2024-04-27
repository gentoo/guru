# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=(python3_{9..12})

EPYTHON=python3

inherit distutils-r1 desktop xdg-utils

_app_id=net.davidotek.pupgui2

DESCRIPTION="Install and manage GE-Proton, Luxtorpeda & more for Steam Lutris and Heroic."
HOMEPAGE="https://davidotek.github.io/protonup-qt"
SRC_URI="https://github.com/DavidoTek/ProtonUp-Qt/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/steam
	dev-python/requests
	dev-python/pyside6[designer(+)]
	dev-python/vdf
	dev-python/pyxdg
	dev-python/pyaml
	dev-python/zstandard
"
DEPEND="${RDEPEND}
	dev-util/desktop-file-utils
	dev-libs/appstream-glib
"

src_compile() {
	appstream-util validate-relax --nonet "share/metainfo/$_app_id.appdata.xml"
	desktop-file-validate "share/applications/$_app_id.desktop"
	distutils-r1_src_compile
}

src_install() {
	distutils-r1_src_install
	domenu "${FILESDIR}/ProtonUp-Qt.desktop"
	dobin "${FILESDIR}/ProtonUp-Qt"
	newicon -s 64 "${WORKDIR}/${P}/share/icons/hicolor/64x64/apps/net.davidotek.pupgui2.png" ProtonUp-Qt.png
	newicon -s 128 "${WORKDIR}/${P}/share/icons/hicolor/128x128/apps/net.davidotek.pupgui2.png" ProtonUp-Qt.png
	newicon -s 256 "${WORKDIR}/${P}/share/icons/hicolor/256x256/apps/net.davidotek.pupgui2.png" ProtonUp-Qt.png
}

pkg_postinst() {
	xdg_icon_cache_update
}
