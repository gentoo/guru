# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
MYPV="${PV/_p/.post}"
MYP="${PN}-${MYPV}"
PYTHON_COMPAT=( python3_{8,9} )

inherit distutils-r1

DESCRIPTION="A CFF table subroutinizer for FontTools"
HOMEPAGE="
	https://github.com/googlefonts/compreffor
	https://pypi.org/project/compreffor/
"
SRC_URI="mirror://pypi/${MYP:0:1}/${PN}/${MYP}.tar.gz"
S="${WORKDIR}/${MYP}"
KEYWORDS="~amd64"
LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="
	>=dev-python/fonttools-4[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	>=dev-python/cython-0.29.24[${PYTHON_USEDEP}]
	dev-python/setuptools_scm[${PYTHON_USEDEP}]
"
BDEPEND="app-arch/unzip"

PATCHES=( "${FILESDIR}/${P}-remove-unwanted-dependencies.patch" )

distutils_enable_tests pytest

python_test() {
	distutils_install_for_testing
	default
}
