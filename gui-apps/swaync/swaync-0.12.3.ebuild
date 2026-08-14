# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
inherit meson vala gnome2-utils python-any-r1
VALA_USE_DEPEND="vapigen"

MY_PN="SwayNotificationCenter"
DESCRIPTION="A simple notification daemon with a GTK gui for notifications and control center"
HOMEPAGE="https://github.com/ErikReider/SwayNotificationCenter"
SRC_URI="https://github.com/ErikReider/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="pulseaudio"

DEPEND="
	dev-lang/sassc
	dev-libs/glib:2
	dev-libs/gobject-introspection
	>=dev-libs/granite-7.0.0:=
	dev-libs/json-glib
	dev-libs/libgee:0.8=
	gui-libs/gtk4-layer-shell[introspection,vala]
	gui-libs/gtk:4[introspection,wayland]
	gui-libs/libadwaita
	gui-libs/libhandy:1
	pulseaudio? ( media-libs/libpulse )
	sys-apps/dbus
	x11-libs/gdk-pixbuf:2
"
RDEPEND="
	${DEPEND}
	x11-libs/cairo
	x11-libs/pango
"
BDEPEND="
	${PYTHON_DEPS}
	$(vala_depend)
	app-text/scdoc
	dev-util/blueprint-compiler
"
# https://bugs.gentoo.org/961696
BDEPEND+=">=dev-build/meson-1.8.2"

src_configure() {
	local emesonargs=($(meson_use pulseaudio pulse-audio))
	meson_src_configure
}

src_prepare() {
	default
	vala_setup
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
