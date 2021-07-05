# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="A web framework for python that is as simple as it is powerful"
HOMEPAGE="
	https://webpy.org
	https://github.com/webpy/webpy
	https://pypi.org/project/web.py
"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/cheroot[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
distutils_enable_sphinx docs

src_prepare() {
	#tests require postgresql and mysql running
	rm tests/test_db.py
	default
}

python_test() {
	#https://github.com/webpy/webpy/issues/712
	#https://github.com/webpy/webpy/issues/713
	epytest -vv \
		--deselect tests/test_application.py::ApplicationTest::test_routing \
		--deselect tests/test_session.py::DiskStoreTest::testStoreConcurrent \
		|| die
}
