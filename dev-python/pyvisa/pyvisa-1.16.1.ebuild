# Copyright 2025-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_USE_PEP517=setuptools
PYPI_PN="pyvisa"
inherit distutils-r1 pypi

DESCRIPTION="Python VISA bindings for GPIB, RS232, TCPIP and USB instruments"
HOMEPAGE="https://github.com/pyvisa/pyvisa https://pypi.org/project/pyvisa/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

# test_visa_info requires installed entry point not available during test phase
EPYTEST_DESELECT=(
	pyvisa/testsuite/test_cmd_line_tools.py::TestCmdLineTools::test_visa_info
)

RDEPEND="
	>=dev-python/typing-extensions-4.0.0[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-python/setuptools-scm[${PYTHON_USEDEP}]
	${RDEPEND}
"

EPYTEST_PLUGINS=( )
distutils_enable_tests pytest
