# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1

DESCRIPTION="A lightweight cross-platform wrapper around a webview component"
HOMEPAGE="https://github.com/r0x0r/pywebview"
SRC_URI="https://github.com/r0x0r/pywebview/archive/${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-python/pygobject[${PYTHON_USEDEP}]
	dev-python/PyQt5[${PYTHON_USEDEP}]
	dev-python/PyQtWebEngine[${PYTHON_USEDEP}]
"
