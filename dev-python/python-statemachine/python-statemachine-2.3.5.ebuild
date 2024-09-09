# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="Python Finite State Machines made easy."
HOMEPAGE="
	https://pypi.org/project/python-statemachine/
	https://github.com/fgmacedo/python-statemachine
"
SRC_URI="https://github.com/fgmacedo/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/pydot[${PYTHON_USEDEP}]"

BDEPEND="
	${RDEPEND}
	test? (
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
		dev-python/pytest-django[${PYTHON_USEDEP}]
		dev-python/django[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	tests/test_mixins.py::test_mixin_should_instantiate_a_machine
)

EPYTEST_IGNORE=(
	tests/test_profiling.py
	tests/django_project/workflow/tests.py
)

python_test() {
	epytest -o 'addopts=""'

}
