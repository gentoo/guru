# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit qmake-utils xdg-utils

DESCRIPTION="GameStream client for PCs"
HOMEPAGE="https://github.com/moonlight-stream/moonlight-qt"
SRC_URI="https://github.com/moonlight-stream/moonlight-qt/releases/download/v${PV}/MoonlightSrc-${PV}.tar.gz"
S="${WORKDIR}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="vaapi"

RDEPEND="
	>=dev-libs/openssl-1.1.1
	>=media-libs/libsdl2-2.0.16-r1:0[kms]
	>=media-libs/sdl2-ttf-2.0.15:0
	>=media-video/ffmpeg-4.4-r1:0
	>=dev-qt/qtsvg-5.15.2-r10:5/5.15
	>=dev-qt/qtquickcontrols2-5.15.2-r11:5
	>=media-libs/opus-1.3.1-r2:0
	>=media-sound/pulseaudio-15.0-r1:0
	vaapi? (
		>=media-libs/libva-2.12.0:0
	)
"
DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig
	dev-qt/qtcore
"
PATCHES=(
	"${FILESDIR}/${PV}-respect-cflags.patch"
)

src_configure() {
	eqmake5 PREFIX="${EPREFIX}/usr"
}

src_install() {
	emake install INSTALL_ROOT="${D}"
	einstalldocs
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
