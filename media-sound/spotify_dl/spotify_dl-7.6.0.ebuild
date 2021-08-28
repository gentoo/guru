# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

MY_PN="${PN/_/-}"

DESCRIPTION="Downloads songs from a Spotify Playlist/Track/Album that you provide"
HOMEPAGE="https://github.com/SathyaBhat/spotify-dl/"
SRC_URI="https://github.com/SathyaBhat/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="test" # tests require network access

S="${WORKDIR}/${MY_PN}-${PV}"

RDEPEND="
	dev-python/spotipy[${PYTHON_USEDEP}]
	media-libs/mutagen[${PYTHON_USEDEP}]
	dev-python/sentry-sdk[${PYTHON_USEDEP}]
	dev-python/peewee[${PYTHON_USEDEP}]
	>=net-misc/youtube-dl-2021.06.06[${PYTHON_USEDEP}]
"
