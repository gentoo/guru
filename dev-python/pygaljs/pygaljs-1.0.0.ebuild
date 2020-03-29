# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="Python package providing assets from https://github.com/Kozea/pygal.js"
HOMEPAGE="
	https://github.com/ionelmc/python-pygaljs
	https://pypi.org/project/pygaljs
"
SRC_URI="https://github.com/ionelmc/python-${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# requires file in src/pygaljs/static that is not in release tarballs
RESTRICT="test"

RDEPEND=""
DEPEND=""

S="${WORKDIR}/python-${P}"

distutils_enable_tests pytest
