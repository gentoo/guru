# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
inherit distutils-r1 pypi

DESCRIPTION="A CFF table subroutinizer for FontTools"
HOMEPAGE="
	https://pypi.org/project/compreffor/
	https://github.com/googlefonts/compreffor
"

KEYWORDS="~amd64"
LICENSE="Apache-2.0"
SLOT="0"

RDEPEND=">=dev-python/fonttools-4[${PYTHON_USEDEP}]"
BDEPEND="
	app-arch/unzip
	>=dev-python/cython-0.29.24[${PYTHON_USEDEP}]
"

PATCHES=( "${FILESDIR}/${PN}-0.5.1_p1-remove-unwanted-dependencies.patch" )

distutils_enable_tests pytest

src_prepare() {
	find "${S}" -name '*.cpp' -delete || die
	distutils-r1_src_prepare
}

python_test() {
	cd "${T}" || die
	epytest --pyargs compreffor
}
