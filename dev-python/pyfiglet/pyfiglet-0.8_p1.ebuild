# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} pypy3 )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

MY_PV="$(ver_cut 1-2).post$(ver_cut 4)"
MY_P="${PN}-${MY_PV}"
DESCRIPTION="Pure-python FIGlet implementation"
HOMEPAGE="https://pypi.org/project/pyfiglet/ https://github.com/pwaller/pyfiglet"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
KEYWORDS="~amd64"
SLOT="0"

# requires subprocess32
RESTRICT="test"

distutils_enable_tests pytest
