# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi xdg

DESCRIPTION="GUI wallpaper setter for Wayland and Xorg window managers"
HOMEPAGE="https://github.com/anufrievroman/waypaper"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/pygobject[${PYTHON_USEDEP}]
	dev-python/platformdirs[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/imageio[${PYTHON_USEDEP}]
	dev-python/imageio-ffmpeg[${PYTHON_USEDEP}]
	dev-python/screeninfo[${PYTHON_USEDEP}]
	x11-libs/gtk+:3[introspection]
	x11-libs/gdk-pixbuf:2[introspection]
"

distutils_enable_tests unittest

python_test() {
	eunittest -s tests
}

python_install_all() {
	distutils-r1_python_install_all

	gunzip "${ED}/usr/share/man/man1/waypaper.1.gz" || die
}
