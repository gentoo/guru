# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Standalone CFF subroutinizer based on AFDKO tx tool"
HOMEPAGE="
	https://pypi.org/project/cffsubr/
	https://github.com/adobe-type-tools/cffsubr
"

KEYWORDS="~amd64"
LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="
	>=dev-python/fonttools-4.10.2[${PYTHON_USEDEP}]
	>=dev-util/afdko-3.6.1[${PYTHON_USEDEP}]
"

PATCHES=(
	"${FILESDIR}/${PN}-system_tx.diff"
	"${FILESDIR}/${P}-fix-setup-py.patch"
)

distutils_enable_tests pytest

src_prepare() {
	# remove bundled afdko
	rm -rf external || die

	distutils-r1_src_prepare
}
