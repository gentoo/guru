# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop
SRC_URI="https://github.com/DavidoTek/ProtonUp-Qt/archive/refs/tags/v${PV}.tar.gz"
DESCRIPTION="Install and manage GE-Proton, Luxtorpeda & more for Steam and Wine-GE & more for Lutris with this graphical user interface."
HOMEPAGE="https://davidotek.github.io/protonup-qt"

LICENSE="GPL-3"
SLOT="0"

DEPEND="dev-python/steam
        dev-python/requests
        dev-python/pyside6[designer(+)]
        dev-python/PyQt6
        dev-python/vdf
        dev-python/pyxdg
        dev-python/pyaml
        dev-python/zstandard
"

KEYWORDS="~amd64"

src_install() {
    insinto /opt/ProtonUp-Qt && doins -r "${WORKDIR}/${P}/pupgui2" && doins -r "${WORKDIR}/${P}/pupgui2"

    insinto /opt/bin/ && doins "${FILESDIR}/ProtonUp-Qt"
    fperms +x /opt/bin/ProtonUp-Qt

    domenu "${FILESDIR}/ProtonUp-Qt.desktop"
    newicon "${WORKDIR}/${P}/share/icons/hicolor/64x64/apps/net.davidotek.pupgui2.png" ProtonUp-Qt.png
}