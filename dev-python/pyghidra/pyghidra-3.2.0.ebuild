# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )
EPYTEST_PLUGINS=( pytest-datadir )

inherit distutils-r1 pypi

DESCRIPTION="Python interface to Ghidra through JPype"
HOMEPAGE="https://github.com/NationalSecurityAgency/ghidra/tree/master/Ghidra/Features/PyGhidra"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

PATCHES=( "${FILESDIR}/${P}-import-hook-test.patch" )

RDEPEND="
	>=dev-python/jpype-1.7.1[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.16[${PYTHON_USEDEP}]
	>=dev-util/ghidra-12.2
"

distutils_enable_tests pytest

python_test() {
	XDG_CONFIG_HOME="${T}" \
		XDG_STATE_HOME="${T}" \
		GHIDRA_INSTALL_DIR="${EPREFIX}/opt/ghidra" epytest
}
