# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} pypy3 )

inherit distutils-r1

DESCRIPTION="This library is provided to allow standard python logging to output log data as json objects"
HOMEPAGE="
	https://github.com/madzak/python-json-logger
	https://pypi.org/project/python-json-logger
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests unittest
