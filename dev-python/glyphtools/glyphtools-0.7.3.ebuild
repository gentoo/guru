# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

DESCRIPTION="Routines for extracting information from fontTools glyphs"
HOMEPAGE="https://github.com/simoncozens/glyphtools"
SRC_URI="https://github.com/simoncozens/glyphtools/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
KEYWORDS="~amd64"
SLOT="0"

RDEPEND="
	dev-python/babelfont[${PYTHON_USEDEP}]
	dev-python/beziers[${PYTHON_USEDEP}]
	dev-python/glyphsLib[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

distutils_enable_tests pytest
distutils_enable_sphinx docs \
	dev-python/sphinxcontrib-napoleon \
	dev-python/sphinxcontrib-restbuilder
