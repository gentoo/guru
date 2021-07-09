# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

DESCRIPTION="Brute force detection of glyph collisions"
HOMEPAGE="https://github.com/simoncozens/collidoscope"
SRC_URI="https://github.com/simoncozens/collidoscope/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64"
SLOT="0"

RDEPEND="
	dev-python/fonttools[${PYTHON_USEDEP}]
	dev-python/glyphtools[${PYTHON_USEDEP}]
	dev-python/pyclipper[${PYTHON_USEDEP}]
	dev-python/uharfbuzz[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
