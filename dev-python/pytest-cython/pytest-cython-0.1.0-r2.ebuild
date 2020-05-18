# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( pypy3 python3_{6,7,8} )
DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1

DESCRIPTION="Plugin for testing Cython extension modules"
HOMEPAGE="https://github.com/lgpage/pytest-cython"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64"
IUSE="test"

#IDK how to run this: python tests/example-project/setup.py clean build_ext --inplace --use-cython
RESTRICT="test"
RDEPEND="
	dev-python/cython[${PYTHON_USEDEP}]
	dev-python/pytest[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
"

src_prepare() {
	sed -i 's|\[pytest\]|\[tool:pytest\]|' setup.cfg || die
	default
}

distutils_enable_sphinx docs dev-python/sphinx-py3doc-enhanced-theme
