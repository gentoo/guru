# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
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

RDEPEND="dev-python/pytest[${PYTHON_USEDEP}]"
BDEPEND="
	test? (
		dev-python/Faker[${PYTHON_USEDEP}]
		dev-python/factory-boy[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
	)
" # tests pytest-xdist integration

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
