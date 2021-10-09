# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{8,9} pypy3 )

inherit distutils-r1

DESCRIPTION="cChardet is high speed universal character encoding detector"
HOMEPAGE="https://github.com/PyYoshi/cChardet"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/chardet[${PYTHON_USEDEP}]
"
#bundled ...
#	app-i18n/uchardet
DEPEND="
	${RDEPEND}
	dev-python/cython[${PYTHON_USEDEP}]
"

distutils_enable_tests nose

#src_prepare() {
#	append-cppflags "-I/usr/include/uchardet"
	#bundled uchardet
#	rm -rf src/ext/uchardet || die
#	default
#}

python_test() {
	esetup.py nosetests || die "Tests fail with ${EPYTHON}"
}
