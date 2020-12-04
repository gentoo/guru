# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1

DESCRIPTION="Python API to MPV using JSON IPC"
HOMEPAGE="https://github.com/iwalton3/python-mpv-jsonipc"
SRC_URI="https://github.com/iwalton3/python-mpv-jsonipc/archive/v${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
