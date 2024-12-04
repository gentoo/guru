# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )
inherit distutils-r1

HASH="e7f7d33b88210fbbbb76d3a6c256bb0de641f3e1"
DESCRIPTION="Construct isolines/isosurfaces of a 2D/3D scalar field defined by a function"
HOMEPAGE="
	https://pypi.org/project/isosurfaces/
	https://github.com/jared-hughes/isosurfaces
"
SRC_URI="https://github.com/jared-hughes/isosurfaces/archive/${HASH}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-${HASH}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]"
