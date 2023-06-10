# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Fast and simple dmenu/rofi replacement for wlroots-based Wayland compositors"
HOMEPAGE="https://github.com/philj56/tofi"
SRC_URI="https://github.com/philj56/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+man"

RDEPEND="
	dev-libs/glib
	dev-libs/wayland
	media-libs/freetype:2
	media-libs/harfbuzz
	x11-libs/cairo
	x11-libs/pango
	x11-libs/libxkbcommon
"

DEPEND="
	${RDEPEND}
	dev-libs/wayland-protocols
	dev-util/wayland-scanner
	elibc_musl? ( sys-libs/fts-standalone )
	"

BDEPEND="
	virtual/pkgconfig
	man? ( app-text/scdoc )
	"

src_configure() {
	local emesonargs=(
		$(meson_feature man man-pages)
	)
	meson_src_configure
}
