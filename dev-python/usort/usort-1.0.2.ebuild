# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_10 ) # python3_11 depends on dev-python/libcst

inherit distutils-r1 pypi

DESCRIPTION="Safe, minimal import sorting for Python projects"
HOMEPAGE="https://github.com/facebookexperimental/usort/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-python/attrs[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/libcst[${PYTHON_USEDEP}]
	dev-python/stdlibs[${PYTHON_USEDEP}]
	dev-python/moreorless[${PYTHON_USEDEP}]
	dev-python/toml[${PYTHON_USEDEP}]
	dev-python/trailrunner[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? ( dev-python/volatile[${PYTHON_USEDEP}] )
"

distutils_enable_tests unittest
