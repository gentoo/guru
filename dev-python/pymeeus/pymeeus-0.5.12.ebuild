# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} pypy3 )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

MY_PN="PyMeeus"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Python implementation of Jean Meeus astronomical routines"
HOMEPAGE="
	https://pypi.org/project/PyMeeus/
	https://github.com/architest/pymeeus
"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests pytest

distutils_enable_sphinx docs/source \
	dev-python/sphinx-rtd-theme
