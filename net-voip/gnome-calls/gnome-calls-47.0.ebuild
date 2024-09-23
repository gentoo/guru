# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
VALA_USE_DEPEND="vapigen"

inherit vala meson gnome2-utils optfeature systemd virtualx xdg

MY_PN="${PN#gnome-}"
MY_P="${MY_PN}-v${PV}"
LCU_V="0.2.1"
DESCRIPTION="Phone dialer and call handler"
HOMEPAGE="https://gitlab.gnome.org/GNOME/calls"
GITLAB="https://gitlab.gnome.org"
SRC_URI="
	${GITLAB}/GNOME/${MY_PN}/-/archive/v${PV}/${MY_P}.tar.bz2
	${GITLAB}/World/Phosh/libcall-ui/-/archive/v${LCU_V}/libcall-ui-v${LCU_V}.tar.bz2
"
S="${WORKDIR}/${MY_P}"

LICENSE="CC0-1.0 CC-BY-SA-4.0 GPL-3+ LGPL-2+ LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="gtk-doc man"

RDEPEND="
	app-crypt/libsecret[introspection,vala]
	dev-libs/feedbackd[introspection,vala]
	dev-libs/folks:=
	>=dev-libs/glib-2.74:2
	dev-libs/gom[introspection]
	dev-libs/libgee:0.8=[introspection]
	dev-libs/libpeas:2
	gnome-extra/evolution-data-server:=[vala]
	>=gui-libs/gtk-4.12:4
	>=gui-libs/libadwaita-1.5:1[introspection,vala]
	media-libs/gst-plugins-base:1.0[introspection]
	media-libs/gstreamer:1.0[introspection]
	media-sound/callaudiod
	net-libs/sofia-sip
	net-misc/modemmanager:=[introspection]
"
DEPEND="${RDEPEND}
	test? ( media-plugins/gst-plugins-srtp:1.0 )
"
BDEPEND="
	$(vala_depend)
	dev-libs/gobject-introspection
	dev-libs/protobuf
	dev-util/wayland-scanner
	sys-devel/gettext
	gtk-doc? ( dev-util/gtk-doc )
	man? ( dev-python/docutils )
"

src_unpack() {
	default

	cd "${S}" || die
	rmdir subprojects/libcall-ui || die
	mv "${WORKDIR}"/libcall-ui-v${LCU_V} subprojects/libcall-ui || die
}

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
		# All tests pass, but the runner doesn't exit and gets timed out
		#calls:application

		# TODO:
		# not ok /Calls/Ringer/accept_call
		# GLib-GObject-FATAL-CRITICAL: cannot register existing type 'LfbEvent'
		#calls:ringer

		# TODO:
		# hangs at /Calls/SIP/calls_direct_call
		#calls:sip
	)

	virtx meson_src_test "${tests[@]}"
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update

	optfeature "SRTP support" media-plugins/gst-plugins-srtp
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
