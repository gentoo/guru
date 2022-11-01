# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

MY_PN="${PN/_/-}"

DESCRIPTION="Downloads songs from a Spotify Playlist/Track/Album that you provide"
HOMEPAGE="https://github.com/SathyaBhat/spotify-dl/"
SRC_URI="https://github.com/SathyaBhat/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

PROPERTIES="test_network"
RESTRICT="test"

S="${WORKDIR}/${MY_PN}-${PV}"

RDEPEND="
	>=dev-python/sentry-sdk-1.5[${PYTHON_USEDEP}]
	<dev-python/sentry-sdk-2[${PYTHON_USEDEP}]
	>=net-misc/yt-dlp-2022.1.21[${PYTHON_USEDEP}]
	>=dev-python/spotipy-2.19[${PYTHON_USEDEP}]
	<dev-python/spotipy-3[${PYTHON_USEDEP}]
	>=media-libs/mutagen-1.45[${PYTHON_USEDEP}]
	<media-libs/mutagen-2[${PYTHON_USEDEP}]
	>=dev-python/rich-12.0[${PYTHON_USEDEP}]
	<dev-python/rich-13[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
