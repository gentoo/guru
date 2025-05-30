# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GNOME_ORG_MODULE="calls"
inherit vala meson gnome.org gnome2-utils optfeature systemd virtualx xdg

DESCRIPTION="Phone dialer and call handler"
HOMEPAGE="https://gitlab.gnome.org/GNOME/calls"
GITLAB="https://gitlab.gnome.org"

LICENSE="CC0-1.0 CC-BY-SA-4.0 GPL-3+ LGPL-2+ LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="gtk-doc man"

COMMON_DEPEND="
	app-crypt/libsecret
	dev-libs/feedbackd
	dev-libs/folks:=
	>=dev-libs/glib-2.74:2
	dev-libs/gom
	dev-libs/libgee:0.8=
	dev-libs/libpeas:2
	gnome-extra/evolution-data-server:=[vala]
	>=gui-libs/gtk-4.12:4
	>=gui-libs/libadwaita-1.6:1
	media-libs/gstreamer:1.0
	media-sound/callaudiod
	net-libs/sofia-sip[glib]
	net-misc/modemmanager:=
"
RDEPEND="${COMMON_DEPEND}
	gnome-base/librsvg:2
"
DEPEND="${COMMON_DEPEND}
	test? (
		media-libs/gst-plugins-base:1.0
		media-libs/gst-plugins-good:1.0
		media-plugins/gst-plugins-srtp:1.0
	)
"
BDEPEND="
	$(vala_depend)
	dev-libs/glib:2
	dev-libs/libxml2
	dev-util/gdbus-codegen
	dev-util/glib-utils
	sys-devel/gettext
	gtk-doc? ( dev-util/gtk-doc )
	man? ( dev-python/docutils )
"

src_prepare() {
	default
	vala_setup
}

src_configure() {
	local emesonargs=(
		$(meson_use gtk-doc gtk_doc)
		$(meson_use man manpages)
		$(meson_use test tests)
		-Dsystemd_user_unit_dir="$(systemd_get_userunitdir)"
	)
	meson_src_configure
}

src_test() {
	local tests=(
		calls:application
		calls:call
		calls:contacts
		calls:emergency-call-types
		calls:dbus
		calls:manager
		calls:media
		calls:origin
		calls:plugins
		calls:provider
		calls:sdp-crypto
		calls:settings
		calls:srtp
		calls:ui-call
		calls:util

		# TODO:
		# not ok /Calls/Ringer/accept_call
		# GLib-GObject-FATAL-CRITICAL: cannot register existing type 'LfbEvent'
		# https://gitlab.gnome.org/GNOME/calls/-/issues/622
		#calls:ringer

		# TODO:
		# hangs at /Calls/SIP/calls_direct_call
		# https://gitlab.gnome.org/GNOME/calls/-/issues/695
		#calls:sip
	)

	virtx meson_src_test "${tests[@]}"
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update

	optfeature "SIP support" "\
		media-libs/gst-plugins-base:1.0 \
		media-libs/gst-plugins-good:1.0 \
		media-plugins/gst-plugins-srtp:1.0 \
	"
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
