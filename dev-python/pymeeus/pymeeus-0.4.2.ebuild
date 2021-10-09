# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="PyMeeus"
MY_P="${MY_PN}-${PV}"

PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

DESCRIPTION="Python implementation of Jean Meeus astronomical routines"
HOMEPAGE="https://github.com/architest/pymeeus"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/${MY_P}"

distutils_enable_tests pytest
distutils_enable_sphinx docs/source dev-python/sphinx_rtd_theme
