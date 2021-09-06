# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

DESCRIPTION="A topological sort for python"
HOMEPAGE="https://gitlab.com/ericvsmith/toposort"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )
"

DOCS=()

python_test() {
	${EPYTHON} setup.py test || die
}
