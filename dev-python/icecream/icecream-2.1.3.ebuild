# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
inherit distutils-r1

DESCRIPTION="Pythonic task execution"
HOMEPAGE="https://github.com/gruns/icecream https://pypi.org/project/icecream/"
SRC_URI="https://github.com/gruns/icecream/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/colorama-0.3.9[${PYTHON_USEDEP}]
	>=dev-python/pygments-2.2.0[${PYTHON_USEDEP}]
	>=dev-python/executing-0.3.1[${PYTHON_USEDEP}]
	>=dev-python/asttokens-2.0.1[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

distutils_enable_tests pytest
EPYTEST_DESELECT=(
	# Seems like those cannot work in the sandbox
	tests/test_icecream.py::TestIceCream::testEnableDisable
	tests/test_icecream.py::TestIceCream::testSingledispatchArgumentToString

	# This one fails on Python3.12 because it is outdated
	tests/test_icecream.py::TestIceCream::testMultilineContainerArgs
)
