# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1

DESCRIPTION="cChardet is high speed universal character encoding detector"
HOMEPAGE="https://github.com/PyYoshi/cChardet"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~amd64"

#tests fail with an import failure
#    from cchardet import _cchardet
#ImportError: cannot import name '_cchardet'
#I tried to manually import _cchardet in ipython3 and it works ...
RESTRICT="test"

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

#python_test() {
#	distutils_install_for_testing
#	"${EPYTHON}" setup.py nosetest || die
#}
