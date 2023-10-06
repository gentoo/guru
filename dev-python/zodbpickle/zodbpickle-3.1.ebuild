# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 edo pypi

DESCRIPTION="Fork of Python's pickle module to work with ZODB"
HOMEPAGE="
	https://pypi.org/project/zodbpickle/
	https://github.com/zopefoundation/zodbpickle
"

LICENSE="PSF-2 ZPL"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	test? (
		dev-python/zope-testrunner[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests unittest

python_test() {
	edo ${EPYTHON} -m zope.testrunner --test-path=src -vv
}
