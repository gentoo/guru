# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..10} pypy3 )
inherit distutils-r1

DESCRIPTION="X11 & Windows cursor building API"
HOMEPAGE="https://github.com/ful1e5/clickgen"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-python/pillow[${PYTHON_USEDEP}]
	media-libs/libpng
	x11-libs/libX11
	x11-libs/libXcursor
	"
