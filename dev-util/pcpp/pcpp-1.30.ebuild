# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..12} pypy3 )

inherit distutils-r1 pypi

DESCRIPTION="A C99 preprocessor written in pure Python"
HOMEPAGE="
	https://pypi.org/project/pcpp/
	https://github.com/ned14/pcpp/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

DOCS=( LICENSE.txt README.rst )

src_prepare() {
	sed -i "s:../LICENSE.txt:LICENSE.txt:" setup.py || die
	distutils-r1_src_prepare
}
