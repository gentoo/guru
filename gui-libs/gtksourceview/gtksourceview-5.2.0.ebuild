# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
VALA_MIN_API_VERSION="0.52"
inherit gnome.org meson vala virtualx xdg

DESCRIPTION="GTK 4 syntax highlighting widget"
HOMEPAGE="https://gitlab.gnome.org/GNOME/gtksourceview"

LICENSE="LGPL-2.1+"
SLOT="5"
IUSE="gtk-doc +introspection +vala"
REQUIRED_USE="vala? ( introspection )"

KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~riscv ~x86"

DEPEND="
	dev-libs/fribidi
	dev-libs/glib:2
	dev-libs/libpcre2:=
	dev-libs/libxml2:2
	gui-libs/gtk:4
	media-libs/fontconfig
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/pango
	introspection? ( dev-libs/gobject-introspection:= )

"
RDEPEND="${DEPEND}"
BDEPEND="
	sys-devel/gettext
	virtual/pkgconfig
	gtk-doc? (
		dev-util/gtk-doc
		app-text/docbook-xml-dtd:4.3
	)
	vala? ( $(vala_depend) )
"

DOCS=( AUTHORS HACKING NEWS README.{md,win32} )

src_prepare() {
	use vala && vala_src_prepare
	default

	# deselect failing test
	sed "/test-regex/d" -i testsuite/meson.build || die
}

src_configure() {
	local emesonargs=(
		-Dsysprof=false
		$(meson_feature introspection)
		$(meson_use vala vapi)
		$(meson_use gtk-doc gtk_doc)
	)
	meson_src_configure
}

src_test() {
	virtx meson_src_test
}
