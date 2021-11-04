# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit qmake-utils
inherit xdg-utils

DESCRIPTION="GameStream client for PCs"

HOMEPAGE="https://github.com/moonlight-stream/moonlight-qt"

SRC_URI="https://github.com/moonlight-stream/moonlight-qt/releases/download/v3.1.4/MoonlightSrc-3.1.4.tar.gz"

S="${WORKDIR}"

LICENSE="GPL-3"

SLOT="0"

KEYWORDS="~amd64"

# Comprehensive list of any and all USE flags leveraged in the ebuild,
# with some exceptions, e.g., ARCH specific flags like "amd64" or "ppc".
# Not needed if the ebuild doesn't use any USE flags.
IUSE="vaapi"

RDEPEND="
	>=dev-libs/openssl-1.1.1l:0/1.1
	>=media-libs/libsdl2-2.0.16-r1:0
	>=media-libs/sdl2-ttf-2.0.15:0
	>=media-video/ffmpeg-4.4-r1:0
	>=dev-qt/qtsvg-5.15.2-r10:5/5.15
	>=dev-qt/qtquickcontrols2-5.15.2-r11:5
	>=media-libs/opus-1.3.1-r2:0
	>=media-sound/pulseaudio-15.0-r1:0
	vaapi? (
		>=x11-libs/libva-2.12.0:0
	)
"

DEPEND="${RDEPEND}"

BDEPEND="
	virtual/pkgconfig
	dev-qt/qtcore
"

src_configure() {
	eqmake5 PREFIX="${D}/usr"
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
