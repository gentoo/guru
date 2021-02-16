# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{7,8,9} )

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

RDEPEND="
	dev-python/docutils[${PYTHON_USEDEP}]
	dev-python/factory_boy[${PYTHON_USEDEP}]
	dev-python/Faker[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pytest[${PYTHON_USEDEP}]

	$(python_gen_cond_dep 'dev-python/importlib_metadata[${PYTHON_USEDEP}]' python3_7)
	$(python_gen_cond_dep 'dev-python/pygments[${PYTHON_USEDEP}]' python3_9)
"
BDEPEND="test? (
	dev-python/pytest-xdist[${PYTHON_USEDEP}]
)"

distutils_enable_tests pytest

python_test() {
	distutils_install_for_testing --via-root
	pytest -vv \
		--deselect tests/test_pytest_randomly.py::test_entrypoint_injection \
		--deselect tests/test_pytest_randomly.py::test_classes_reordered \
		--deselect tests/test_pytest_randomly.py::test_doctests_reordered \
		--deselect tests/test_pytest_randomly.py::test_class_test_methods_reordered \
		--deselect tests/test_pytest_randomly.py::test_files_reordered \
		--deselect tests/test_pytest_randomly.py::test_test_functions_reordered \
		--deselect tests/test_pytest_randomly.py::test_test_functions_reordered_when_randomness_in_module \
		--deselect tests/test_pytest_randomly.py::test_files_reordered_when_seed_not_reset \
		--deselect tests/test_pytest_randomly.py::test_doctests_in_txt_files_reordered \
	|| die "Testsuite failed under ${EPYTHON}"
}
