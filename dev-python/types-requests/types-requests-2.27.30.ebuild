# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} pypy3 )

inherit distutils-r1

DESCRIPTION="Typing stubs for requests"
HOMEPAGE="
	https://pypi.org/project/types-requests/
	https://github.com/python/typeshed/tree/master/stubs/requests
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="~amd64"

RDEPEND="<dev-python/types-urllib3-1.27"
DEPEND="${RDEPEND}"
