# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils meson xdg

DESCRIPTION="Modern and user-friendly media player"
HOMEPAGE="https://github.com/Rafostar/clapper"
SRC_URI="https://github.com/Rafostar/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="|| ( GPL-3 LGPL-2.1 )"
SLOT="0"
KEYWORDS="~amd64"
IUSE="discoverer doc egl gles2 +gstreamer +gtk gui +introspection mpris rawimporter server vala wayland X"

RDEPEND="
	>=dev-libs/glib-2.76.0:2
	>=media-libs/gstreamer-1.20.0:1.0
	media-libs/graphene
	media-libs/gst-plugins-base:1.0[egl?,gles2?,opengl,wayland?,X?]
	>=gui-libs/gtk-4.10.0:4[wayland?,X?]
	>=gui-libs/libadwaita-1.4.0:1
	x11-libs/pango

	doc? (
		dev-util/gi-docgen
		media-gfx/graphviz
	)
	introspection? ( dev-libs/gobject-introspection )
	server? ( net-libs/libmicrodns )
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-libs/appstream-glib
	dev-libs/glib
	sys-devel/gettext

	introspection? ( dev-libs/gobject-introspection )
"

src_configure() {
	local emesonargs=(
		-Dclapper=enabled
		-Dvapi=disabled
		$(meson_feature gtk clapper-gtk)
		$(meson_feature gui clapper-app)
		$(meson_feature discoverer discoverer)
		$(meson_use doc doc)
		$(meson_feature gstreamer gst-plugin)
		$(meson_feature gstreamer glimporter)
		$(meson_feature gstreamer gluploader)
		$(meson_feature introspection introspection)
		$(meson_feature mpris mpris)
		$(meson_feature rawimporter rawimporter)
		$(meson_feature server server)
	)
	meson_src_configure
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
