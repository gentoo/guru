# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..13} )
inherit distutils-r1

DESCRIPTION="Multi-platform system-wide hotkeys"
HOMEPAGE="https://github.com/timeyyy/system_hotkey"
SRC_URI="https://github.com/timeyyy/system_hotkey/archive/refs/tags/${PV}.tar.gz
			-> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

# TODO this depends on xpybutil
RDEPEND=">=dev-python/xcffib-1.5.0"

distutils_enable_tests unittest
