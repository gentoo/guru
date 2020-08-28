# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{7,8,9} pypy3 )

inherit distutils-r1

DESCRIPTION="Python Data Validation for Humans"
HOMEPAGE="
	https://github.com/kvesteri/validators
	https://pypi.org/project/validators
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="MIT"
SLOT="0"

RDEPEND="
	>=dev-python/decorator-3.4.0[${PYTHON_USEDEP}]
	>=dev-python/six-1.4.0[${PYTHON_USEDEP}]
"

python_prepare_all() {
	# sphinx.ext.pngmath has been replace in sphinx>2
	sed -i -e 's/sphinx.ext.pngmath/sphinx.ext.imgmath/g' docs/conf.py || die

	distutils-r1_python_prepare_all
}

distutils_enable_tests pytest
distutils_enable_sphinx docs
