# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..13} )
inherit distutils-r1

DESCRIPTION="Advanced multi monitor wallpaper manager"
HOMEPAGE="https://github.com/hhannine/superpaper"
SRC_URI="https://github.com/hhannine/superpaper/archive/refs/tags/v${PV}.tar.gz
			-> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/wxpython-4.0
		>=dev-python/pillow-7.0.0
		>=dev-python/screeninfo-0.6.1
		>=dev-python/numpy-1.18.0
		>=dev-python/system_hotkey-1.0
		>=dev-python/xcffib-0.8.0
		>=dev-python/xpybutil-0.0.5"
