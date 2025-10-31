# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="New version checker for software releases"
HOMEPAGE="https://github.com/lilydjwg/nvchecker/"

SRC_URI="https://github.com/lilydjwg/nvchecker/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="aiohttp"

RDEPEND="
	dev-python/structlog[${PYTHON_USEDEP}]
	!aiohttp? (
		dev-python/pycurl[${PYTHON_USEDEP}]
		dev-python/tornado[${PYTHON_USEDEP}]
	)
	aiohttp? (
		dev-python/aiohttp[${PYTHON_USEDEP}]
	)
"
