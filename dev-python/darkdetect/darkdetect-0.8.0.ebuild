# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..11} pypy3  )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Detect OS dark mode from Python"
HOMEPAGE="https://github.com/5yutan5/PyQtDarkTheme https://pypi.org/project/PyQtDarkTheme"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
