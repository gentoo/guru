# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MYPN="${PN}.py"
PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

DESCRIPTION="Python bezier manipulation library"
HOMEPAGE="https://github.com/simoncozens/beziers.py"
SRC_URI="https://github.com/simoncozens/${MYPN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MYPN}-${PV}"

LICENSE="MIT"
KEYWORDS="~amd64"
SLOT="0"

RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pyclipper[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
	sci-libs/shapely[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? (
		dev-python/dotmap[${PYTHON_USEDEP}]
		dev-python/matplotlib[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
