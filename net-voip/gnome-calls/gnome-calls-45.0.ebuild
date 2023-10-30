# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
VALA_USE_DEPEND="vapigen"

inherit vala meson gnome2-utils optfeature virtualx xdg

MY_PN="${PN#gnome-}"
MY_P="${MY_PN}-v${PV}"
LCU_V="0.1.0"
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
	dev-libs/glib:2
	dev-libs/gom[introspection]
	dev-libs/libgee:0.8=[introspection]
	dev-libs/libpeas
	gnome-extra/evolution-data-server:=[vala]
	gui-libs/libhandy:1[introspection,vala]
	media-libs/gstreamer:1.0[introspection]
	media-sound/callaudiod
	net-libs/sofia-sip
	net-misc/modemmanager:=[introspection]
	x11-libs/gtk+:3
"
DEPEND="${RDEPEND}
	test? ( media-plugins/gst-plugins-srtp:1.0 )
"
BDEPEND="
	$(vala_depend)
	dev-libs/gobject-introspection
	dev-libs/protobuf
	dev-util/wayland-scanner
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
	)
	meson_src_configure
}

src_test() {
	local tests=(
		calls:application
		calls:call
		calls:contacts
		calls:dbus
		calls:manager
		calls:media
		calls:origin
		calls:plugins
		calls:provider
		calls:ringer
		calls:sdp-crypto
		calls:settings
		#calls:sip
		calls:srtp
		calls:ui-call
		calls:util
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
