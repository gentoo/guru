# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} pypy3 )

inherit distutils-r1

DESCRIPTION="Python bindings for GitHub's cmark"
HOMEPAGE="https://github.com/theacodes/cmarkgfm"
SRC_URI="https://github.com/theacodes/cmarkgfm/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64"
SLOT="0"

RDEPEND="
	app-text/cmark-gfm
	virtual/python-cffi[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
BDEPEND="app-text/dos2unix"

PATCHES=( "${FILESDIR}/${P}-use-system-cmark-gfm.patch" )

src_prepare() {
	dos2unix src/cmarkgfm/build_cmark.py || die
	default
}

distutils_enable_tests pytest
