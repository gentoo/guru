# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..11} pypy3  )
DISTUTILS_USE_PEP517=poetry
inherit distutils-r1

DESCRIPTION="A flat dark theme for PySide and PyQt. "
HOMEPAGE="https://github.com/5yutan5/PyQtDarkTheme https://pypi.org/project/PyQtDarkTheme"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
DEPEND="
	dev-python/darkdetect[${PYTHON_USEDEP}]
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
