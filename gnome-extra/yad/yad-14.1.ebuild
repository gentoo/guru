# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools gnome2-utils xdg

DESCRIPTION="Display GTK+ dialog boxes from command line or shell scripts"
HOMEPAGE="https://github.com/v1cont/yad/"

if [[ "${PV}" = 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/v1cont/yad.git"
else
	SRC_URI="https://github.com/v1cont/yad/releases/download/v${PV}/${P}.tar.xz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="+deprecated +icon-browser +sourceview +spell standalone +tools +tray +webkit"
RESTRICT="test"

DEPEND="
	app-accessibility/at-spi2-core:2
	dev-libs/expat
	dev-libs/fribidi
	dev-libs/glib:2
	dev-libs/libffi:=
	dev-libs/libpcre2:=
	dev-libs/wayland
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
	>=x11-libs/gtk+-3.22.0:3
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
	sourceview? ( >=x11-libs/gtksourceview-3.18.0:3.0= )

	spell? (
		app-text/enchant:2
		app-text/gspell:=
		dev-libs/icu:=
	)

	webkit? ( net-libs/webkit-gtk:4.1 )
"

BDEPEND="
	>=dev-build/autoconf-2.59
	>=dev-build/automake-1.11
	>=dev-util/intltool-0.40.0
	sys-devel/gettext
	virtual/pkgconfig
"

RDEPEND="${DEPEND}"

DOCS=(
	AUTHORS
	ChangeLog.old
	NEWS
	README.md
	THANKS
	TODO
)

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable webkit html) \
		$(use_enable tray) \
		$(use_enable spell) \
		$(use_enable sourceview) \
		$(use_enable standalone) \
		$(use_enable deprecated) \
		$(use_enable tools) \
		$(use_enable icon-browser)
}

pkg_preinst() {
	xdg_pkg_preinst
	use standalone || gnome2_schemas_savelist
}

pkg_postinst() {
	xdg_pkg_postinst
	use standalone || gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	use standalone || gnome2_schemas_update
}
