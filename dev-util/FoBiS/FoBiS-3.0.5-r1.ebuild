# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1

DESCRIPTION="FoBiS.py, a Fortran Building System for poor men"
HOMEPAGE="https://github.com/szaghi/FoBiS"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}.py/${PN}.py-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="graphviz"

S="${WORKDIR}/${PN}.py-${PV}"

RDEPEND="
	graphviz? ( dev-python/graphviz[${PYTHON_USEDEP}] )
"

# removing "import future" and "from past.utils import old_div" from python scripts
PATCHES=( "${FILESDIR}/${PN}-3.0.2-remove-import-future_olddiv.patch" )
