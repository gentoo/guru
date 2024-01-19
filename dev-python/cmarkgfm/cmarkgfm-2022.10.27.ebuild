# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} pypy3 )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 edos2unix

DESCRIPTION="Python bindings for GitHub's cmark"
HOMEPAGE="https://github.com/theacodes/cmarkgfm"
SRC_URI="https://github.com/theacodes/cmarkgfm/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64"
SLOT="0"

RDEPEND="
	app-text/cmark-gfm
	$(python_gen_cond_dep 'dev-python/cffi[${PYTHON_USEDEP}]' 'python*')
"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}/${PN}-0.6.0-use-system-cmark-gfm.patch" )

src_prepare() {
	edos2unix src/cmarkgfm/build_cmark.py
	default
}

distutils_enable_tests pytest
