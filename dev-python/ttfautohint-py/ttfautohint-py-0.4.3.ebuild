# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

SRC_URI="https://github.com/fonttools/ttfautohint-py/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"
DESCRIPTION="A Python wrapper for ttfautohint"
HOMEPAGE="https://github.com/fonttools/ttfautohint-py"
LICENSE="MIT"
SLOT="0"

RDEPEND="media-gfx/ttfautohint"
DEPEND="
	test? (
		dev-python/fonttools[${PYTHON_USEDEP}]
	)
"

PATCHES=( "${FILESDIR}/${P}-no-ext_modules.patch" )

distutils_enable_tests pytest

src_prepare() {
	rm -r src/c || die
	export SETUPTOOLS_SCM_PRETEND_VERSION="${PV%_*}"
	default
}
