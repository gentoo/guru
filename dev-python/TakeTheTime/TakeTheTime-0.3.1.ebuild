# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} pypy3 )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Take The Time, a super-neat Python library for timing chunks of code"
HOMEPAGE="https://github.com/ErikBjare/TakeTheTime"
LICENSE="MIT"

SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64"
SLOT="0"

# Not available for now
RESTRICT="test"
