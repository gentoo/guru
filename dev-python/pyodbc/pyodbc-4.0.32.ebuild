# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} pypy3 )

inherit distutils-r1

DESCRIPTION="Python ODBC library"
HOMEPAGE="
	http://code.google.com/p/pyodbc
	https://github.com/mkleehammer/pyodbc
	https://pypi.org/project/pyodbc
"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="mssql"

RDEPEND="
	>=dev-db/unixODBC-2.3.0
	mssql? ( >=dev-db/freetds-0.64[odbc] )
"
DEPEND="${RDEPEND}"
