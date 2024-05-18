# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=poetry
inherit distutils-r1

DESCRIPTION="Send videos from many, many online sources to your Chromecast"
HOMEPAGE="https://github.com/skorokithakis/catt"
SRC_URI="https://github.com/skorokithakis/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

# Seems that all tests makes external connections
RESTRICT="test"

DEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/pychromecast[${PYTHON_USEDEP}]
	dev-python/ifaddr[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	net-misc/yt-dlp[${PYTHON_USEDEP}]
"

RDEPEND="${DEPEND}"

#distutils_enable_tests pytest
