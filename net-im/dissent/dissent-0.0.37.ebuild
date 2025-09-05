# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop go-module unpacker xdg

DESCRIPTION="Tiny native Discord app"
HOMEPAGE="https://github.com/diamondburned/dissent"
SRC_URI="https://github.com/diamondburned/${PN}/releases/download/v${PV}/${PN}-source.tar.zst -> ${P}.tar.zst"

S=${WORKDIR}

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=gui-libs/gtk-4.10.0
	>=gui-libs/libadwaita-1.4.0
	>=gui-libs/gtksourceview-5.8.0:5
	>=media-libs/gstreamer-1.20.0:1.0
	>=media-libs/gst-plugins-base-1.20.0:1.0
	>=media-libs/gst-plugins-good-1.20.0:1.0
	>=media-libs/gst-plugins-bad-1.20.0:1.0
	>=media-libs/gst-plugins-ugly-1.20.0:1.0
	>=media-libs/graphene-1.10.0
	>=app-text/libspelling-0.2.0
	>=x11-libs/cairo-1.16.0
	>=x11-libs/gdk-pixbuf-2.42.0:2
	>=dev-libs/glib-2.72.0:2
	>=x11-libs/pango-1.50.0
	>=media-libs/harfbuzz-5.0.0
	>=dev-libs/libxml2-2.9.0
"

DEPEND="${RDEPEND}"
BDEPEND="
	>=dev-lang/go-1.21.0
	virtual/pkgconfig
"

RESTRICT="test"

src_prepare() {
	default

	# everything is readonly
	chmod -R u+w "${S}" || die

	# file missing from upstream, causes build failure
	cp "${FILESDIR}"/modules.txt "${S}"/vendor || die

	# comments out DBusActivatable which is problematic with launchers
	sed -i 's/^\(DBusActivatable=.*\)$/# \1/' nix/so.libdb.dissent.desktop || die
}

src_compile() {
	export CGO_LDFLAGS="-Wl,--as-needed"

	ego build -v -x -buildmode=pie -ldflags "-s -w" -o ${PN}
}

src_install() {
	dobin ${PN}

	domenu nix/so.libdb.dissent.desktop

	insinto /usr/share/dbus-1/services
	doins nix/so.libdb.dissent.service

	doicon -s scalable internal/icons/hicolor/scalable/apps/so.libdb.dissent.svg

	insinto /usr/share/metainfo
	doins so.libdb.dissent.metainfo.xml

	einstalldocs
}

pkg_postinst() {
	xdg_pkg_postinst
}
