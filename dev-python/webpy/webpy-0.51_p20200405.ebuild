# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{7,8} )

inherit distutils-r1

COMMIT="16de3147e61aa4dc735efa116c50603707fb0683"

DESCRIPTION="A web framework for python that is as simple as it is powerful"
HOMEPAGE="
	https://webpy.org/
	https://github.com/webpy/webpy
	https://pypi.org/project/web.py
"
SRC_URI="https://github.com/${PN}/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-python/cheroot-6.0.0[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? (
		>=dev-python/pytest-5.4.1[${PYTHON_USEDEP}]
	)
"

S="${WORKDIR}/${PN}-${COMMIT}"

distutils_enable_tests pytest
distutils_enable_sphinx docs

src_prepare() {
	#tests require postgresql and mysql running
	rm tests/test_db.py || die
	default
}
