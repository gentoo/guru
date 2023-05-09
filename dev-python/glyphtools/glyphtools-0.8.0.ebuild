# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )
inherit distutils-r1 pypi

DESCRIPTION="Routines for extracting information from fontTools glyphs"
HOMEPAGE="https://github.com/simoncozens/glyphtools"

LICENSE="Apache-2.0"
KEYWORDS="~amd64"
SLOT="0"

RDEPEND="
	dev-python/babelfont[${PYTHON_USEDEP}]
	dev-python/beziers[${PYTHON_USEDEP}]
	dev-python/glyphsLib[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

distutils_enable_sphinx docs \
	dev-python/sphinxcontrib-restbuilder
