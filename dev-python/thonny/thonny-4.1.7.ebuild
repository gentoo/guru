# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..14} )
PYTHON_REQ_USE="tk"

inherit desktop distutils-r1 xdg-utils

DESCRIPTION="Thonny is a Python IDE meant for learning programming."
HOMEPAGE="
	https://thonny.org/ https://github.com/thonny/thonny"
SRC_URI="
	https://github.com/thonny/thonny/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RESTRICT="!test? ( test )"

RDEPEND="
	$(python_gen_cond_dep '
		>=dev-python/jedi-0.18.1[${PYTHON_USEDEP}]
		dev-python/setuptools[${PYTHON_USEDEP}]
		dev-python/pyserial[${PYTHON_USEDEP}]
		dev-python/pylint[${PYTHON_USEDEP}]
		dev-python/docutils[${PYTHON_USEDEP}]
		dev-python/mypy[${PYTHON_USEDEP}]
		dev-python/asttokens[${PYTHON_USEDEP}]
		dev-python/send2trash[${PYTHON_USEDEP}]
	' 'python*'
	)
"

BDEPEND="
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
	)
"

src_prepare() {
	default
}

src_install() {
	distutils-r1_src_install
	newicon packaging/icons/thonny-32x32.png thonny.png
	domenu ${S}/packaging/linux/org.thonny.Thonny.desktop
}

pkg_postinst() {
	xdg_pkg_postinst
	elog "Thonny has been installed."
	elog "To use Thonny with a specific Python version, you can set"
	elog "the interpreter in Tools -> Options -> Interpreter"
	elog ""
	elog "For MicroPython/CircuitPython support, you may need additional"
	elog "packages like dev-python/esptool or dev-python/adafruit-ampy"
}

pkg_postrm() {
	xdg_pkg_postrm
}
