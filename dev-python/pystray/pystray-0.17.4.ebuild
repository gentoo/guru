# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1

DESCRIPTION="System tray icon creation via python"
HOMEPAGE="https://github.com/moses-palmer/pystray"
SRC_URI="https://github.com/moses-palmer/pystray/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

DEPEND="dev-python/sphinx[${PYTHON_USEDEP}]"
RDEPEND="
	${DEPEND}
	dev-python/python-xlib[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/pillow[${PYTHON_USEDEP}]"
