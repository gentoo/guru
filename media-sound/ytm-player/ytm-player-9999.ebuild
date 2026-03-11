# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1 optfeature

DESCRIPTION="Full-featured YouTube Music TUI client with vim-style navigation"
HOMEPAGE="https://github.com/peternaame-boop/ytm-player"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/peternaame-boop/ytm-player.git"
else
	SRC_URI="https://github.com/peternaame-boop/ytm-player/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

RDEPEND="
	media-video/mpv
	net-misc/yt-dlp
	>=dev-python/aiosqlite-0.20.0[${PYTHON_USEDEP}]
	>=dev-python/click-8.1.0[${PYTHON_USEDEP}]
	>=dev-python/python-mpv-1.0.0[${PYTHON_USEDEP}]
	>=dev-python/pillow-10.0[${PYTHON_USEDEP}]
	>=dev-python/textual-7.0.0[${PYTHON_USEDEP}]
	>=dev-python/ytmusicapi-1.11.0[${PYTHON_USEDEP}]
"

BDEPEND="
	test? (
		dev-python/anyascii[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=( pytest-asyncio )
distutils_enable_tests pytest

pkg_postinst() {
	optfeature "MPRIS media key support" dev-python/dbus-next
	optfeature "last.fm scrobbling" dev-python/pylast
	optfeature "Discord rich presence" dev-python/pypresence
	optfeature "spotify playlist import" dev-python/spotipy
}

python_test() {
	# The default portage tempdir is too long for AF_UNIX sockets
	local -x TMPDIR=/tmp
	epytest
}
