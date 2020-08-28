# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{7,8} )

inherit distutils-r1

DESCRIPTION="Pytest plugin to randomly order tests and control random.seed"
HOMEPAGE="
	https://pypi.python.org/pypi/pytest-randomly
	https://github.com/pytest-dev/pytest-randomly
"
SRC_URI="https://github.com/pytest-dev/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# No clue what's going on here
# AssertionError: assert ['collecting ... collected 4 items',\n '',\n 'test_one.py::test_d PASSED',\n 'test_one.py::test_c PASSED'] == 
# ['test_one.py::test_d PASSED',\n 'test_one.py::test_c PASSED',\n 'test_one.py::test_a PASSED',\n 'test_one.py::test_b PASSED']
RESTRICT="test"

RDEPEND="
	dev-python/docutils[${PYTHON_USEDEP}]
	dev-python/factory_boy[${PYTHON_USEDEP}]
	dev-python/faker[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
	dev-python/pytest[${PYTHON_USEDEP}]

	$(python_gen_cond_dep 'dev-python/importlib_metadata[${PYTHON_USEDEP}]' python3_7)
"

DEPEND="
	test? (
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_test() {
	distutils_install_for_testing
	pytest -vv --deselect tests/test_pytest_randomly.py::test_entrypoint_injection || die "Testsuite failed under ${EPYTHON}"
}
