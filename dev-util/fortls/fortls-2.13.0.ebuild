# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Fortran Language Server (fortls)"
HOMEPAGE="https://fortls.fortran-lang.org"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/json5[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	test/test_interface.py::test_version_update_pypi
)

src_prepare() {
	# Drop some additional coverage tests
	sed -i -e 's/ --cov=fortls --cov-report=html --cov-report=xml --cov-context=test//' pyproject.toml || die
	# Disable autoupdate check during tests run
	sed -i -e 's/"--incremental_sync",/"--incremental_sync", "--disable_autoupdate",/' test/setup_tests.py || die

	distutils-r1_src_prepare
}
