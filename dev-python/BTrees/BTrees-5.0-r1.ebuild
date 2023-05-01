# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

PYPI_NO_NORMALIZE=1
inherit distutils-r1 pypi

DESCRIPTION="scalable persistent components"
HOMEPAGE="https://github.com/zopefoundation/BTrees"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/persistent[${PYTHON_USEDEP}]
	dev-python/zope-interface[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
BDEPEND="
	doc? (
		dev-python/repoze-sphinx-autointerface[${PYTHON_USEDEP}]
		dev-python/sphinx-rtd-theme[${PYTHON_USEDEP}]
	)
	test? (
		dev-python/persistent[${PYTHON_USEDEP}]
		dev-python/transaction[${PYTHON_USEDEP}]
		dev-python/zope-testrunner[${PYTHON_USEDEP}]
	)
"

distutils_enable_sphinx docs
distutils_enable_tests pytest

python_test() {
	zope-testrunner -pvc -j "$(nproc)" --usecompiled \
		--path "${BUILD_DIR}/install$(python_get_sitedir)/" || die
}
