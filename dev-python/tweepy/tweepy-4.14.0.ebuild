# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_11 )

inherit distutils-r1

DESCRIPTION="An easy-to-use Python library for accessing the Twitter API."
HOMEPAGE="https://www.tweepy.org/"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64"
LICENSE="MIT"
SLOT="0"

RDEPEND="
	dev-python/requests[${PYTHON_USEDEP},socks5]
	dev-python/requests-oauthlib[${PYTHON_USEDEP}]
"

DEPEND="
	${RDEPEND}
"
	# test? (
	# 	dev-python/aiohttp[${PYTHON_USEDEP}]
	# 	dev-python/async-lru[${PYTHON_USEDEP}]
	# 	dev-python/mock[${PYTHON_USEDEP}]
	# 	<dev-python/urllib3-2.0.0[${PYTHON_USEDEP}]
	# 	dev-python/vcrpy[${PYTHON_USEDEP}]
	# )

# Removed from ::gentoo
# distutils_enable_tests nose
