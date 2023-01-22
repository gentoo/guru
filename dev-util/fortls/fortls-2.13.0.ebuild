# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1

DESCRIPTION="Fortran Language Server (fortls)"
HOMEPAGE="https://fortls.fortran-lang.org"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

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
