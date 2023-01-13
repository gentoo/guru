# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_10 )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Brute force detection of glyph collisions"
HOMEPAGE="https://github.com/simoncozens/collidoscope"
SRC_URI="https://github.com/simoncozens/collidoscope/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64"
SLOT="0"

RDEPEND="
	>=dev-python/beziers-0.0.3[${PYTHON_USEDEP}]
	dev-python/fonttools[${PYTHON_USEDEP}]
	dev-python/glyphtools[${PYTHON_USEDEP}]
	dev-python/uharfbuzz[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
