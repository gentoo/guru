# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

DESCRIPTION="A Python wrapper for ttfautohint"
HOMEPAGE="https://github.com/fonttools/ttfautohint-py"
SRC_URI="https://github.com/fonttools/ttfautohint-py/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"
LICENSE="MIT"
SLOT="0"

RDEPEND="media-gfx/ttfautohint"
DEPEND="
	${RDEPEND}
	dev-python/setuptools_scm[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/fonttools[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

src_prepare() {
	rm -r src/c || die
	export SETUPTOOLS_SCM_PRETEND_VERSION="${PV%_*}"
	export TTFAUTOHINTPY_BUNDLE_DLL=0
	default
}
