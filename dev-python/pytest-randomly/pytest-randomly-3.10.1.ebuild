# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8,9} )

inherit distutils-r1

DESCRIPTION="Pytest plugin to randomly order tests and control random.seed"
HOMEPAGE="
	https://pypi.python.org/pypi/pytest-randomly
	https://github.com/pytest-dev/pytest-randomly
"
SRC_URI="https://github.com/pytest-dev/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/factory_boy[${PYTHON_USEDEP}]
	dev-python/Faker[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pytest[${PYTHON_USEDEP}]
	dev-python/pytest-xdist[${PYTHON_USEDEP}]

	$(python_gen_cond_dep '>=dev-python/importlib_metadata-3.6.0[${PYTHON_USEDEP}]' python3_{8,9})
"
DEPEND="${RDEPEND}"

distutils_enable_tests pytest

python_test() {
	distutils_install_for_testing --via-root
	pytest -vv \
		--deselect tests/test_pytest_randomly.py::test_entrypoint_injection \
		|| die "Testsuite failed under ${EPYTHON}"
}
