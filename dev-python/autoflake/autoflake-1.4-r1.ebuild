# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} pypy3 )

inherit distutils-r1

DESCRIPTION="Removes unused imports and unused variables as reported by pyflakes"
HOMEPAGE="
	https://github.com/myint/autoflake
	https://pypi.org/project/autoflake
"
SRC_URI="https://github.com/myint/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND=">=dev-python/pyflakes-1.1.0[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

RESTRICT="!test? ( test )"

python_test() {
	"${EPYTHON}" test_autoflake.py || die
}
