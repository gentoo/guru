# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..13} )
PYTHON_REQ_USE="tk"

inherit desktop distutils-r1 xdg optfeature

DESCRIPTION="Thonny is a Python IDE meant for learning programming"
HOMEPAGE="
	https://thonny.org/ https://github.com/thonny/thonny"
SRC_URI="
	https://github.com/thonny/thonny/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/jedi-0.18.1[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/pyserial[${PYTHON_USEDEP}]
	dev-python/pylint[${PYTHON_USEDEP}]
	dev-python/docutils[${PYTHON_USEDEP}]
	dev-python/mypy[${PYTHON_USEDEP}]
	dev-python/asttokens[${PYTHON_USEDEP}]
	dev-python/send2trash[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

src_install() {
	distutils-r1_src_install
	newicon packaging/icons/thonny-32x32.png thonny.png
	domenu "${S}/packaging/linux/org.thonny.Thonny.desktop"
}

pkg_postinst() {
	xdg_pkg_postinst
	optfeature "CircuitPython support" dev-python/esptool
	optfeature "MicroPython support" dev-python/adafruit-ampy
}

pkg_postrm() {
	xdg_pkg_postrm
}
