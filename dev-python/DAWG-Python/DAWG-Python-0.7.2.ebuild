# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} pypy3  )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Pure-python reader for DAWGs (DAFSAs) created by dawgdic C++ library."
HOMEPAGE="
	https://github.com/pytries/DAWG-Python
	https://pypi.org/project/DAWG-Python/
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
