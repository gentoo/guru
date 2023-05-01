# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Python wrapper for ttfautohint, a free auto-hinter for TrueType fonts"
HOMEPAGE="
	https://pypi.org/project/ttfautohint-py/
	https://github.com/fonttools/ttfautohint-py
"
SRC_URI="https://github.com/fonttools/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

KEYWORDS="~amd64"
LICENSE="MIT"
SLOT="0"

RDEPEND="media-gfx/ttfautohint"
BDEPEND="
	dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? (
		dev-python/fonttools[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

src_prepare() {
	distutils-r1_src_prepare
	rm -r src/c || die
}

src_configure() {
	export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}
}
