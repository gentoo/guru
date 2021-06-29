# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} pypy3 )

inherit distutils-r1

DESCRIPTION="Independent BSON codec for Python that doesn't depend on MongoDB"
HOMEPAGE="https://github.com/py-bson/bson"
SRC_URI="https://github.com/py-bson/bson/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="
	>=dev-python/python-dateutil-2.4.0[${PYTHON_USEDEP}]
	>=dev-python/six-1.9.0[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"

python_test() {
	"${EPYTHON}" test.py || die
}
