# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{7..9} pypy3 )

inherit distutils-r1

DESCRIPTION="Python package providing assets from https://github.com/Kozea/pygal.js"
HOMEPAGE="
	https://github.com/ionelmc/python-pygaljs
	https://pypi.org/project/pygaljs
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=""
DEPEND=""

distutils_enable_tests pytest
