# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
VALA_USE_DEPEND="vapigen"

inherit vala meson gnome2-utils xdg

LCU_COMMIT="acfbb136bbf74514e0b9801ce6c1e8acf36350b6"
DESCRIPTION="Phone dialer and call handler"
HOMEPAGE="https://gitlab.gnome.org/GNOME/calls"
SRC_URI="
	https://gitlab.gnome.org/GNOME/calls/-/archive/${PV}/calls-${PV}.tar.gz
	https://gitlab.gnome.org/World/Phosh/libcall-ui/-/archive/${LCU_COMMIT}/libcall-ui-${LCU_COMMIT}.tar.gz
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="+introspection +vala"
REQUIRED_USE="vala? ( introspection )"

DEPEND="
		dev-libs/feedbackd
		>=gui-libs/libhandy-1.0.0
		dev-libs/folks
		dev-libs/gom
		dev-libs/libpeas
		>=net-misc/modemmanager-1.12.0
		>=media-sound/callaudiod-0.0.5
		gnome-extra/evolution-data-server
		net-libs/sofia-sip
		dev-libs/protobuf
		"
RDEPEND="${DEPEND}"
BDEPEND="
		vala? ( $(vala_depend) )
		dev-util/meson
		dev-libs/gobject-introspection
		dev-util/wayland-scanner
"

S="${WORKDIR}/calls-${PV}"

src_prepare() {
	default
	eapply_user
	use vala && vala_src_prepare

	rm -r "${S}"/subprojects/libcall-ui || die
	mv "${WORKDIR}"/libcall-ui-"${LCU_COMMIT}" "${S}"/subprojects/libcall-ui || die
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
