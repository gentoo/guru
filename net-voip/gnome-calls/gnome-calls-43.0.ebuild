# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
VALA_USE_DEPEND="vapigen"

inherit vala meson gnome2-utils virtualx xdg

MY_PN="${PN#gnome-}"
LCU_COMMIT="619dd91561ad470db3d0e0e263ebc35d787afd2e"
DESCRIPTION="Phone dialer and call handler"
HOMEPAGE="https://gitlab.gnome.org/GNOME/calls"
GITLAB="https://gitlab.gnome.org"
SRC_URI="
	${GITLAB}/GNOME/${MY_PN}/-/archive/v${PV}/${MY_PN}-v${PV}.tar.gz
	${GITLAB}/World/Phosh/libcall-ui/-/archive/${LCU_COMMIT}/libcall-ui-${LCU_COMMIT}.tar.gz
"
S="${WORKDIR}/${MY_PN}-v${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

DEPEND="
	app-accessibility/at-spi2-core:2
	app-crypt/libsecret[introspection(+),vala(+)]
	dev-libs/feedbackd[introspection(+),vala(+)]
	dev-libs/folks:=
	dev-libs/glib:2
	dev-libs/gobject-introspection
	dev-libs/gom[introspection(+)]
	dev-libs/libgee:0.8=[introspection(+)]
	dev-libs/libpeas
	dev-libs/libxml2
	gnome-extra/evolution-data-server:=[vala(+)]
	>=gui-libs/libhandy-1.0.0:1[introspection(+),vala(+)]
	media-libs/gstreamer:1.0[introspection(+)]
	media-libs/harfbuzz:=
	>=media-sound/callaudiod-0.0.5
	net-libs/libsoup:2.4
	net-libs/sofia-sip
	>=net-misc/modemmanager-1.12.0:=[introspection(+)]
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/pango
"
RDEPEND="${DEPEND}
	virtual/secret-service
"
BDEPEND="
	$(vala_depend)
	dev-libs/gobject-introspection
	dev-libs/protobuf
	dev-util/wayland-scanner
"

src_unpack() {
	default

	rm -r "${S}"/subprojects/libcall-ui || die
	mv "${WORKDIR}"/libcall-ui-${LCU_COMMIT} "${S}"/subprojects/libcall-ui || die
}

src_prepare() {
	default
	vala_setup
}

src_test() {
	virtx meson_src_test
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
