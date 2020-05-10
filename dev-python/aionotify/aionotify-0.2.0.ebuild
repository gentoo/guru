# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1

DESCRIPTION="Simple, asyncio-based inotify library for Python"
HOMEPAGE="https://github.com/rbarrois/aionotify"
SRC_URI="https://github.com/rbarrois/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

#DEPEND="test? ( dev-python/asynctest[${PYTHON_USEDEP}] )"
#
#distutils_enable_tests pytest
