# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Pytest plugin to randomly order tests and control random.seed"
HOMEPAGE="
	https://pypi.python.org/pypi/pytest-randomly/
	https://github.com/pytest-dev/pytest-randomly
"
SRC_URI="https://github.com/pytest-dev/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/pytest[${PYTHON_USEDEP}]
	$(python_gen_cond_dep '>=dev-python/importlib_metadata-3.6.0[${PYTHON_USEDEP}]' python3_{8,9})
"
# tests pytest-xdist integration
BDEPEND="test? (
	dev-python/factory_boy[${PYTHON_USEDEP}]
	dev-python/Faker[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pytest-xdist[${PYTHON_USEDEP}]
)"

EPYTEST_DESELECT=(
	tests/test_pytest_randomly.py::test_entrypoint_injection
	tests/test_pytest_randomly.py::test_it_runs_before_stepwise
	tests/test_pytest_randomly.py::test_works_without_xdist

	# Output mismatch
	tests/test_pytest_randomly.py::test_class_test_methods_reordered
	tests/test_pytest_randomly.py::test_classes_reordered
	tests/test_pytest_randomly.py::test_doctests_in_txt_files_reordered
	tests/test_pytest_randomly.py::test_doctests_reordered
	tests/test_pytest_randomly.py::test_files_reordered
	tests/test_pytest_randomly.py::test_files_reordered_when_seed_not_reset
	tests/test_pytest_randomly.py::test_test_functions_reordered
	tests/test_pytest_randomly.py::test_test_functions_reordered_when_randomness_in_module
)

distutils_enable_tests pytest

python_test() {
	epytest -p no:randomly
}
