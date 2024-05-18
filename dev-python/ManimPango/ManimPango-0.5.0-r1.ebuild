# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

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
	# doc? (
	# 	dev-python/furo[${PYTHON_USEDEP}]
	# 	dev-python/sphinxext-opengraph[${PYTHON_USEDEP}]
	# )
DEPEND="${BDEPEND}"

src_prepare() {
	# The tests always fails (ManimPango has to be installed for them to work)
	rm -rf "${S}/tests"
	distutils-r1_src_prepare
}

# distutils_enable_sphinx docs # We need a lot of other packages if we allow doc
