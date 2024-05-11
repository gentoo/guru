# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils xdg-utils desktop
DESCRIPTION="GUI application to generate an SDL2 mapping string from a generic controller"
HOMEPAGE="https://gitlab.com/ryochan7/sdl2-gamepad-mapper"
SRC_URI="https://gitlab.com/ryochan7/sdl2-gamepad-mapper/-/archive/v${PV}/${PN}-v${PV}.tar.bz2"
S="${WORKDIR}/${PN}-v${PV}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
RDEPEND="
	media-libs/libsdl2
	dev-qt/qtdeclarative:6
	dev-qt/qttranslations:6
"
DEPEND="${RDEPEND}"
DOCS=( README.md COPYING )

src_configure() {
	eqmake6
}

src_install() {
	dobin "${PN}"
	domenu "${PN}.desktop"
	doicon -s 512 "${PN}.png"
	einstalldocs
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
