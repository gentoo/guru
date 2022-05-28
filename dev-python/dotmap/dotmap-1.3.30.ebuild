# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} pypy3 )

inherit distutils-r1

DESCRIPTION="Dot access dictionary with dynamic hierarchy creation and ordered iteration"
HOMEPAGE="
	https://github.com/drgrib/dotmap
	https://pypi.org/project/dotmap/
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64"
SLOT="0"

distutils_enable_tests unittest
