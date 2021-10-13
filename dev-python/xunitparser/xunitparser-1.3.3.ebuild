# Copyright 2012-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_8 )

inherit distutils-r1

DESCRIPTION="Read JUnit/XUnit XML files and map them to Python objects"
HOMEPAGE="https://pypi.python.org/pypi/xunitparser"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="test" #why? have you tried to fix the iasue?

distutils_enable_tests unittest

DOCS=( README LICENSE AUTHORS )
