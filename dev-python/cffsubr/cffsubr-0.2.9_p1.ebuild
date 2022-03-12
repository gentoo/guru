# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
MYPV="${PV/_p/.post}"
PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

DESCRIPTION="Standalone CFF subroutinizer based on AFDKO tx tool"
HOMEPAGE="https://github.com/adobe-type-tools/cffsubr"
SRC_URI="https://github.com/adobe-type-tools/cffsubr/archive/refs/tags/v${MYPV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MYPV}"
KEYWORDS="~amd64"
LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="
	>=dev-python/fonttools-4.10.2[${PYTHON_USEDEP}]
	>=dev-util/afdko-3.6.1[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	dev-python/setuptools_scm[${PYTHON_USEDEP}]
"

PATCHES=(
	"${FILESDIR}/${PN}-system_tx.diff"
	"${FILESDIR}/${P}-fix-setup-py.patch"
)

distutils_enable_tests pytest

pkg_setup() {
	export SETUPTOOLS_SCM_PRETEND_VERSION="${PV%_*}"
}

src_prepare() {
	#no bundled afdko
	rm -rf external || die
	default
}
