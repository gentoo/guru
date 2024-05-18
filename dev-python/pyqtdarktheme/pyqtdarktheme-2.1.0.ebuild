# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{10..12} pypy3  )
DISTUTILS_USE_PEP517=poetry
inherit distutils-r1 pypi

DESCRIPTION="A flat dark theme for PySide and PyQt. "
HOMEPAGE="https://github.com/5yutan5/PyQtDarkTheme https://pypi.org/project/PyQtDarkTheme"
DEPEND="
	dev-python/darkdetect[${PYTHON_USEDEP}]
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
