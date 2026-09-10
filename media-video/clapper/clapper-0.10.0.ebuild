# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils meson vala xdg

DESCRIPTION="Modern and user-friendly media player"
HOMEPAGE="
	https://rafostar.github.io/clapper/
	https://github.com/Rafostar/clapper
"
SRC_URI="https://github.com/Rafostar/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="|| ( GPL-3 LGPL-2.1 )"
SLOT="0"
KEYWORDS="~amd64"
IUSE="X graphviz +egl +gtk gtk-doc gui +introspection opengl +plugins vala wayland"
REQUIRED_USE="
	gtk-doc? ( introspection )
	gui? ( gtk )
	opengl? (
		gtk
		|| ( X wayland )
		wayland? ( egl )
	)
	vala? ( introspection )
"
# Uncomment for testing with pkg-testing-tool
# REQUIRED_USE+="
# 	X? ( opengl )
# 	graphviz? ( gui )
# 	egl? ( opengl )
# 	wayland? ( opengl )
# "

RDEPEND="
	>=dev-libs/glib-2.76.0:2
	>=media-libs/gstreamer-1.24.0:1.0[introspection?]
	>=media-libs/gst-plugins-base-1.24.0:1.0[introspection?]
	gtk? (
		>=gui-libs/gtk-4.10.0:4[introspection?]
		media-libs/graphene
		gui? (
			>=gui-libs/libadwaita-1.5.0:1
			x11-libs/pango
			graphviz? ( media-gfx/graphviz:= )
		)
		opengl? (
			media-libs/gst-plugins-base:1.0[X=,egl=,opengl,wayland=]
			gui-libs/gtk:4[X?,wayland?]
		)
	)
	plugins? ( dev-libs/libpeas:2 )
"
DEPEND="${RDEPEND}
	introspection? ( dev-libs/gobject-introspection )
"
BDEPEND="
	dev-util/glib-utils
	virtual/pkgconfig
	gtk? (
		dev-libs/glib:2
		sys-devel/gettext
	)
	gtk-doc? (
		dev-util/gi-docgen
		media-gfx/graphviz
	)
	introspection? ( dev-libs/gobject-introspection )
	vala? ( $(vala_depend) )
"

src_prepare() {
	default
	use vala && vala_setup
}

src_configure() {
	local emesonargs=(
		# Build
		-Dclapper=enabled
		$(meson_feature gtk clapper-gtk)
		$(meson_feature gui clapper-app)
		$(meson_feature gtk gst-plugin)
		$(meson_feature introspection)
		$(meson_feature vala vapi)
		$(meson_use gtk-doc doc)

		# Functionalities
		$(meson_feature plugins enhancers-loader)
		$(meson_feature graphviz pipeline-preview)

		# Features (deprecated in 0.10.0)
		-Ddiscoverer=disabled
		-Dmpris=disabled
		-Dserver=disabled

		# GStreamer plugin options
		$(meson_feature gtk rawimporter)
		$(meson_feature opengl glimporter)
		$(meson_feature opengl gluploader)
	)
	meson_src_configure
}

src_test() {
	# No meaningful tests
	:
}

src_install() {
	meson_src_install
	if use gtk-doc; then
		local gtk_docdir="${ED}/usr/share/gtk-doc/html"
		mkdir -p "${gtk_docdir}" || die
		mv "${ED}"/usr/share/doc/clapper "${gtk_docdir}" || die
		if use gtk; then
			mv "${ED}"/usr/share/doc/clapper-gtk "${gtk_docdir}" || die
		fi
	fi
}

pkg_postinst() {
	use gui || return 0

	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	use gui || return 0

	xdg_pkg_postrm
	gnome2_schemas_update
}
