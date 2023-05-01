# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 pypi

DESCRIPTION="Fork of Python's pickle module to work with ZODB"
HOMEPAGE="https://github.com/zopefoundation/zodbpickle"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	<dev-python/packaging-22.0
	test? ( dev-python/zope-testrunner[${PYTHON_USEDEP}] )
"
DEPEND="${RDEPEND}"

distutils_enable_tests setup.py

python_test() {
	zope-testrunner -pvcD --usecompiled \
		--path="${BUILD_DIR}/install$(python_get_sitedir)/zodbpickle" || die
}

python_install() {
	# Don't install tests
	# rm -r "${BUILD_DIR}/install$(python_get_sitedir)/zodbpickle/tests" || die
	distutils-r1_python_install
}

python_test() {
	zope-testrunner -pvc -j "$(nproc)" --usecompiled \
		--path "${BUILD_DIR}/install$(python_get_sitedir)" || die
}
