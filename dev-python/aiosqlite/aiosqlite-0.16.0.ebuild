# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )
DISTUTILS_USE_SETUPTOOLS=no

inherit distutils-r1

DESCRIPTION="asyncio bridge to the standard sqlite3 module"
HOMEPAGE="https://github.com/jreese/aiosqlite"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="test? (
	dev-python/aiounittest[${PYTHON_USEDEP}]
)"

distutils_enable_tests unittest
# TypeError: add_source_parser() takes 2 positional arguments but 3 were given
#distutils_enable_sphinx docs
