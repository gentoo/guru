# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{7,8,9} )

inherit distutils-r1

DESCRIPTION="A web framework for python that is as simple as it is powerful"
HOMEPAGE="
	https://webpy.org/
	https://github.com/webpy/webpy
"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-python/cheroot[${PYTHON_USEDEP}]
"
BDEPEND="test? (
		>=dev-python/pytest-4.6.2[${PYTHON_USEDEP}]
)"

distutils_enable_tests pytest
distutils_enable_sphinx docs

src_prepare() {
	#tests require postgresql and mysql running
	rm tests/test_db.py
	default
}
