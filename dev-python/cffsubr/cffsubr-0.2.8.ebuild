# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_8 )

inherit distutils-r1

SRC_URI="https://github.com/adobe-type-tools/cffsubr/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"
DESCRIPTION="Standalone CFF subroutinizer based on AFDKO tx tool"
HOMEPAGE="https://github.com/adobe-type-tools/cffsubr"
LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="
	>=dev-util/afdko-3.6.1[${PYTHON_USEDEP}]
"
BDEPEND="
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
