# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOCS_BUILDER="sphinx"
DOCS_DEPEND="
	dev-python/furo
	dev-python/matplotlib
	dev-python/sphinxcontrib-applehelp
	dev-python/sphinxcontrib-devhelp
	dev-python/sphinxcontrib-htmlhelp
	dev-python/sphinxcontrib-jsmath
	dev-python/sphinxcontrib-qthelp
	dev-python/sphinxcontrib-serializinghtml
	dev-python/sphinxext-opengraph
"
DOCS_DIR="docs"

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} pypy3 )

inherit distutils-r1 docs

DESCRIPTION="Binding for Pango, to use with Manim."
HOMEPAGE="https://github.com/ManimCommunity/ManimPango https://pypi.org/project/manimpango"
SRC_URI="https://github.com/ManimCommunity/ManimPango/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug"

RDEPEND="
	dev-libs/glib:2
	media-libs/fontconfig
	x11-libs/cairo
	x11-libs/pango
"
BDEPEND="
	>=dev-python/cython-3.0.2[${PYTHON_USEDEP}]
	x11-libs/pango
"
DEPEND="${BDEPEND}"

src_prepare() {
	sed -i -e '/--cov/d' "${S}/setup.cfg"
	distutils-r1_src_prepare
}

python_compile_all() {
	# Need to remove this, otherwise docs_compile fails
	rm -rf "${S}/manimpango" || die
	docs_compile
}

distutils_enable_tests pytest
