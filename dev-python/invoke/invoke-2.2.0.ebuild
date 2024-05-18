# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
inherit distutils-r1

DESCRIPTION="Pythonic task execution"
HOMEPAGE="https://github.com/pyinvoke/invoke https://pypi.org/project/invoke/"
SRC_URI="https://github.com/pyinvoke/invoke/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	test? (
		dev-python/decorator[${PYTHON_USEDEP}]
		>=dev-python/icecream-2.1[${PYTHON_USEDEP}]
		>=dev-python/pytest-cov-4[${PYTHON_USEDEP}]
		>=dev-python/pytest-relaxed-2[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
EPYTEST_DESELECT=(
	# Most of those fails with "OSError: reading from stdin while output is captured"
	# seems like it is because I do the testing in a chroot
	# Because there are 112 tests that fails, I'd rather skip the file than manually add 112 tests
	tests/runners.py
)
