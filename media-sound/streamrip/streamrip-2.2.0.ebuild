# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="A fast, all-in-one music downloader for Qobuz, Deezer, Tidal, and SoundCloud"
HOMEPAGE="https://github.com/nathom/streamrip"
SRC_URI="https://github.com/nathom/streamrip/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/aiodns[${PYTHON_USEDEP}]
	dev-python/aiofiles[${PYTHON_USEDEP}]
	dev-python/aiohttp[${PYTHON_USEDEP}]
	dev-python/aiolimiter[${PYTHON_USEDEP}]
	dev-python/appdirs[${PYTHON_USEDEP}]
	dev-python/click-help-colors[${PYTHON_USEDEP}]
	dev-python/deezer-py[${PYTHON_USEDEP}]
	dev-python/m3u8[${PYTHON_USEDEP}]
	dev-python/pathvalidate[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/pycryptodome[${PYTHON_USEDEP}]
	dev-python/rich[${PYTHON_USEDEP}]
	dev-python/simple-term-menu[${PYTHON_USEDEP}]
	dev-python/tomlkit[${PYTHON_USEDEP}]
	media-libs/mutagen[${PYTHON_USEDEP}]
"

# Both install `/usr/bin/rip`
DEPEND+="
	!!media-sound/rip
"

EPYTEST_PLUGINS=( pytest-asyncio )
distutils_enable_tests pytest

src_prepare() {
	sed -i "s/Cryptodome/Crypto/g" \
		"streamrip/client/deezer.py" \
		"streamrip/client/downloadable.py" || die

	distutils-r1_src_prepare
}

src_install() {
	distutils-r1_src_install

	dodoc LICENSE
}
