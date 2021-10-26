# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} pypy3 )

inherit distutils-r1

DESCRIPTION="Transaction management for Python"
HOMEPAGE="
	https://pypi.python.org/pypi/transaction
	https://github.com/zopefoundation/transaction
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/zope-interface[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="
	test? (
		dev-python/mock[${PYTHON_USEDEP}]
	)
"

DOCS="CHANGES.rst README.rst"

distutils_enable_tests nose
distutils_enable_sphinx docs

src_test() {
	cd src || die
	python_foreach_impl python_test
}
