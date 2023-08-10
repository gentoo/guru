# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
inherit desktop distutils-r1 xdg-utils

SRC_URI="https://github.com/nwg-piotr/azote/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"

DESCRIPTION="Wallpaper manager for wlroots-based compositors and some other WMs"
HOMEPAGE="https://github.com/nwg-piotr/azote"
LICENSE="MIT"
SLOT="0"
IUSE="X wayland"

RDEPEND="
	dev-python/pillow
	dev-python/pygobject
	x11-libs/gtk+:3

	wayland? ( || ( gui-apps/wlr-randr  gui-apps/swaybg ) )
	X? ( || ( x11-apps/xrandr media-gfx/feh ) )
"
DEPEND="${RDEPEND}"

python_install_all() {
	distutils-r1_python_install_all
	dobin dist/azote
	domenu dist/azote.desktop
	newicon dist/azote.svg azote.svg
	insinto /usr/share/pixmaps/${PN}
	doins dist/indicator*.png
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
