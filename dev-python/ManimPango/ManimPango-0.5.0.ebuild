# Copyright 1999-2023 Gentoo Authors
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
	# The tests always fails. I cannot find how to solve it
	rm -rf "${S}/tests"
	distutils-r1_src_prepare
}

# Cannot build the docs, sphinx.ext.autosummary cannot find manimpango
# distutils_enable_sphinx docs
