# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} pypy3 )

inherit distutils-r1

DESCRIPTION="Python bezier manipulation library"
HOMEPAGE="https://github.com/simoncozens/opentypespec-py"
SRC_URI="https://github.com/simoncozens/opentypespec-py/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-py-${PV}"

LICENSE="Apache-2.0"
KEYWORDS="~amd64"
SLOT="0"

RESTRICT="test" #https://github.com/simoncozens/opentypespec-py/issues/1

distutils_enable_tests setup.py
