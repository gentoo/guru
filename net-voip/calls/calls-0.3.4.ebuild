# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_USE_DEPEND="vapigen"

inherit vala meson gnome2-utils xdg

MY_P="${PN}-v${PV}"

DESCRIPTION="Phone dialer and call handler"
HOMEPAGE="https://source.puri.sm/Librem5/calls"
SRC_URI="https://source.puri.sm/Librem5/calls/-/archive/v0.3.4/calls-v0.3.4.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

IUSE="+introspection +vala"
REQUIRED_USE="vala? ( introspection )"

DEPEND="
	dev-libs/feedbackd
	dev-libs/folks
	dev-libs/gom
	dev-libs/libpeas
	gnome-extra/evolution-data-server
	>=gui-libs/libhandy-1.1.90
	>=media-sound/callaudiod-0.0.5
	>=net-misc/modemmanager-1.12.0
	net-libs/sofia-sip
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-libs/gobject-introspection
	dev-util/meson
	dev-util/wayland-scanner
	vala? ( $(vala_depend) )
"

PATCHES=( "${FILESDIR}/0001-use-at-cmds-to-mute.patch" )

S="${WORKDIR}/${MY_P}"

src_prepare() {
	default
	eapply_user
	use vala && vala_src_prepare
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
