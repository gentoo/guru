# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} pypy3 )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Removes unused imports and unused variables as reported by pyflakes"
HOMEPAGE="
	https://github.com/myint/autoflake
	https://pypi.org/project/autoflake/
"
SRC_URI="https://github.com/myint/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/pyflakes-1.1.0[${PYTHON_USEDEP}]"

distutils_enable_tests setup.py

python_test() {
	"${EPYTHON}" test_autoflake.py || die
}
