# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Python package to handle tiles and points of different projections."
HOMEPAGE="https://github.com/geometalab/pyGeoTile"

MY_PN="pyGeoTile"
COMMIT_ID="c744e540ba698fbe0d822616a62702918d24f71e" # No tags or releases in the github repo
SRC_URI="https://github.com/geometalab/${MY_PN}/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${COMMIT_ID}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="mirror"

distutils_enable_tests pytest
