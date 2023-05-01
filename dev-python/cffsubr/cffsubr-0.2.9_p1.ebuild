# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_10 )
inherit distutils-r1

MY_PV="${PV/_p/.post}"
DESCRIPTION="Standalone CFF subroutinizer based on AFDKO tx tool"
HOMEPAGE="https://github.com/adobe-type-tools/cffsubr"
SRC_URI="https://github.com/adobe-type-tools/${PN}/archive/refs/tags/v${MY_PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-${MY_PV}"

KEYWORDS="~amd64"
LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="
	>=dev-python/fonttools-4.10.2[${PYTHON_USEDEP}]
	>=dev-util/afdko-3.6.1[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-python/setuptools-scm[${PYTHON_USEDEP}]
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
	default

	# remove bundled afdko
	rm -rf external || die
}
