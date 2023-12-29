# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Utility to extract data from XML/HTML documents using XPath or CSS selectors"
HOMEPAGE="
	https://scrapy.org/
	https://pypi.org/project/parsel/
	https://github.com/scrapy/parsel
"

LICENSE="BSD"
SLOT=0
KEYWORDS="~amd64"

RDEPEND="
	dev-python/cssselect[${PYTHON_USEDEP}]
	dev-python/jmespath[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/w3lib[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/psutil[${PYTHON_USEDEP}]
		dev-python/sybil[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

distutils_enable_sphinx docs \
	dev-python/sphinx-notfound-page \
	dev-python/sphinx-rtd-theme

src_prepare() {
	distutils-r1_src_prepare
	sed "/pytest-runner/d" -i setup.py || die
}

python_test() {
	epytest --ignore=docs
}
