# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg cmake optfeature

MY_P="QLivePlayer-${PV}"

DESCRIPTION="A cute and useful Live Stream Player with danmaku support"
HOMEPAGE="https://github.com/IsoaSFlus/QLivePlayer"
SRC_URI="https://github.com/IsoaSFlus/QLivePlayer/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	media-video/mpv
	media-video/ffmpeg
	net-misc/curl
	dev-python/aiohttp
	>=dev-lang/python-3.7.0
"
DEPEND="
	kde-frameworks/extra-cmake-modules
	>=dev-qt/qtcore-5.12
	>=dev-qt/qtquickcontrols-5.12
	>=dev-qt/qtquickcontrols2-5.12
	>=dev-qt/qtgraphicaleffects-5.12
"

pkg_postinst()
{
	xdg_pkg_postinst
	optfeature "twitch support" "net-misc/streamlink"
	optfeature "youtube support" "net-misc/streamlink dev-python/protobuf-python"
}
