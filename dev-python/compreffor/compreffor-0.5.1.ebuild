# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{8,9} )
DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1

SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.zip"
KEYWORDS="~amd64"
DESCRIPTION="A CFF table subroutinizer for FontTools"
HOMEPAGE="https://github.com/googlefonts/compreffor"
LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="
	>=dev-python/fonttools-4.2.0[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
"
BDEPEND="
	app-arch/unzip
	dev-python/cython[${PYTHON_USEDEP}]
"
PATCHES=( "${FILESDIR}/remove-pytest-runner.patch" )

distutils_enable_tests pytest

python_test() {
	distutils_install_for_testing
	default
}
