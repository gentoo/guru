# Copyright 2025-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_USE_PEP517=setuptools
PYPI_PN="pyvisa_py"
inherit distutils-r1 pypi

DESCRIPTION="Pure Python implementation of a VISA library"
HOMEPAGE="https://github.com/pyvisa/pyvisa-py https://pypi.org/project/pyvisa-py/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="serial usb"

RDEPEND="
	>=dev-python/pyvisa-1.15.0[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	serial? ( >=dev-python/pyserial-3.0[${PYTHON_USEDEP}] )
	usb? ( dev-python/pyusb[${PYTHON_USEDEP}] )
"
BDEPEND="
	dev-python/setuptools-scm[${PYTHON_USEDEP}]
	${RDEPEND}
"

EPYTEST_PLUGINS=( )
distutils_enable_tests pytest
