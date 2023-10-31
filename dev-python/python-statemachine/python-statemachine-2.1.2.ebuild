# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_11 )

inherit distutils-r1

DESCRIPTION="Python Finite State Machines made easy."
HOMEPAGE="
	https://pypi.org/project/python-statemachine/
	https://github.com/fgmacedo/python-statemachine
"
SRC_URI="https://github.com/fgmacedo/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/pydot[${PYTHON_USEDEP}]"

BDEPEND="
	${RDEPEND}
	test? (
		dev-python/pytest-mock[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_test() {
	epytest -o 'addopts=""' --ignore=tests/test_profiling.py
}
