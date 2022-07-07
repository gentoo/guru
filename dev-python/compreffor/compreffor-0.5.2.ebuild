# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )
inherit distutils-r1

MY_P="${PN}-${PV/_p/.post}"
DESCRIPTION="A CFF table subroutinizer for FontTools"
HOMEPAGE="
	https://github.com/googlefonts/compreffor
	https://pypi.org/project/compreffor/
"
SRC_URI="mirror://pypi/${MY_P:0:1}/${PN}/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

KEYWORDS="~amd64"
LICENSE="Apache-2.0"
SLOT="0"

RDEPEND=">=dev-python/fonttools-4[${PYTHON_USEDEP}]"
DEPEND=">=dev-python/cython-0.29.24[${PYTHON_USEDEP}]"
BDEPEND="
	app-arch/unzip
	dev-python/setuptools_scm[${PYTHON_USEDEP}]
"

PATCHES=( "${FILESDIR}/${PN}-0.5.1_p1-remove-unwanted-dependencies.patch" )

distutils_enable_tests pytest

python_test() {
	cd "${T}" || die
	epytest --pyargs compreffor
}
