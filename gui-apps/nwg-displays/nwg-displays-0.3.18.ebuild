# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
inherit desktop distutils-r1 xdg-utils

DESCRIPTION="Output management utility for sway and Hyprland"
HOMEPAGE="https://github.com/nwg-piotr/nwg-displays"
SRC_URI="https://github.com/nwg-piotr/nwg-displays/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	gui-apps/wlr-randr
	x11-libs/gtk+:3
"
DEPEND="${RDEPEND}"

python_install_all() {
	distutils-r1_python_install_all
	domenu nwg-displays.desktop
	doicon nwg-displays.svg
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
