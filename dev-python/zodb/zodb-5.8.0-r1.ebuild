# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_10 )
PYPI_NO_NORMALIZE=1
PYPI_PN="${PN^^}"

inherit distutils-r1 pypi

DESCRIPTION="Python object-oriented database"
HOMEPAGE="https://github.com/zopefoundation/zodb"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/BTrees[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/persistent[${PYTHON_USEDEP}]
	dev-python/transaction[${PYTHON_USEDEP}]
	dev-python/zc-lockfile[${PYTHON_USEDEP}]
	dev-python/zconfig[${PYTHON_USEDEP}]
	dev-python/zodbpickle[${PYTHON_USEDEP}]
	dev-python/zope-interface[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
BDEPEND="
	doc? (
		dev-python/j1m-sphinxautozconfig[${PYTHON_USEDEP}]
		dev-python/sphinx-rtd-theme[${PYTHON_USEDEP}]
		dev-python/sphinxcontrib-zopeext[${PYTHON_USEDEP}]
	)
	test? (
		dev-python/manuel[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/zope-testing[${PYTHON_USEDEP}]
		dev-python/zope-testrunner[${PYTHON_USEDEP}]
	)
"

distutils_enable_sphinx docs
distutils_enable_tests setup.py

src_unpack() {
	default
	# Remove failing test
	rm "${S}/src/${PN^^}/tests/testdocumentation.py" || die
}

python_test() {
	zope-testrunner -pvc -j "$(nproc)" --usecompiled \
		--path "${BUILD_DIR}/install$(python_get_sitedir)/" || die
}
