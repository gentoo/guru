# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1

DESCRIPTION="Yet another Discord overlay for Linux written in Python using GTK3."
HOMEPAGE="https://github.com/trigg/Discover"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/pygobject-3.22
	dev-python/websocket-client
	dev-python/pyxdg
	dev-python/requests
	>=dev-python/python-pidfile-3.0.0
	dev-python/pillow"
