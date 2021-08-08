# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} pypy3 )
PYTHON_REQ_USE="sqlite"
inherit distutils-r1

DESCRIPTION="Diff and patch tables"
HOMEPAGE="https://github.com/paulfitz/daff"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~riscv ~sparc ~x86"

python_test() {
	"${EPYTHON}" test/test_example.py || die
	"${EPYTHON}" test/test_sqlite.py || die
}
