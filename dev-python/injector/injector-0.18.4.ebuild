# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )
inherit distutils-r1

DESCRIPTION="Python dependency injection framework"
HOMEPAGE="
		https://pypi.org/project/injector
		https://github.com/alecthomas/injector
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64"
LICENSE="BSD"
SLOT="0"

DEPEND="dev-python/typing-extensions[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
