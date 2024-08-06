# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A wayland based logout menu"
HOMEPAGE="https://github.com/ArtsyMacaw/wlogout/"

if [[ "${PV}" = 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ArtsyMacaw/wlogout.git"
else
	SRC_URI="https://github.com/ArtsyMacaw/wlogout/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
RESTRICT="test"

DEPEND="
	app-accessibility/at-spi2-core:2
	dev-libs/expat
	dev-libs/fribidi
	dev-libs/glib:2
	dev-libs/libffi:=
	dev-libs/libpcre2:=
	dev-libs/wayland
	gui-libs/gtk-layer-shell
	media-gfx/graphite2
	media-libs/fontconfig:1.0
	media-libs/freetype:2
	media-libs/harfbuzz:=
	media-libs/libepoxy
	media-libs/libjpeg-turbo:=
	media-libs/libpng:=
	sys-apps/dbus
	sys-libs/zlib:=
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3[wayland]
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libxcb:=
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libxkbcommon
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/pango
	x11-libs/pixman
"

BDEPEND="
	virtual/pkgconfig
	app-text/scdoc
"

RDEPEND="${DEPEND}"

DOCS=(
	example.png
	README.md
)

PATCHES=( "${FILESDIR}/${P}-fix-cflags.patch" )

src_configure() {
	local emesonargs=( -Dman-pages=enabled )
	meson_src_configure
}
