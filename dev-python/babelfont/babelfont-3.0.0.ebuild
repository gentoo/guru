# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=poetry
inherit distutils-r1 pypi

DESCRIPTION="Interrogate and manipulate UFO, TTF and OTF fonts with a common interface"
HOMEPAGE="
	https://github.com/simoncozens/babelfont
	https://pypi.org/project/babelfont/
"

KEYWORDS="~amd64"
LICENSE="MIT"
SLOT="0"

RDEPEND="
	>=dev-python/cu2qu-1.6.7[${PYTHON_USEDEP}]
	>=dev-python/fontFeatures-1.0.6[${PYTHON_USEDEP}]
	>=dev-python/fonttools-4.21.1[${PYTHON_USEDEP}]
	>=dev-python/glyphsLib-5.3.2[${PYTHON_USEDEP}]
	>=dev-python/openstep-plist-0.2.2[${PYTHON_USEDEP}]
	>=dev-python/orjson-3.5.1[${PYTHON_USEDEP}]
	>=dev-python/ufoLib2-0.11.1[${PYTHON_USEDEP}]
"

# no tests in pypi release
RESTRICT="test"

distutils_enable_tests pytest
