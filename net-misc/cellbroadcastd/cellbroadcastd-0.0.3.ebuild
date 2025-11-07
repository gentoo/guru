# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson systemd vala verify-sig

DESCRIPTION="DBus service for cellular broadcast messages"
HOMEPAGE="https://gitlab.freedesktop.org/devrtz/cellbroadcastd"
SRC_URI="https://sources.phosh.mobi/releases/${PN}/${P}.tar.xz
	verify-sig? ( https://sources.phosh.mobi/releases/${PN}/${P}.tar.xz.asc )"

LICENSE="GPL-3+ LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+introspection vala"
REQUIRED_USE="vala? ( introspection )"

RDEPEND="
	>=dev-libs/glib-2.76.0:2
	>=dev-libs/gmobile-0.4.0
	gnome-base/gsettings-desktop-schemas
	net-misc/mobile-broadband-provider-info
	>=net-misc/modemmanager-1.24.0:=
	sys-apps/dbus
	introspection? ( dev-libs/gobject-introspection )
"
DEPEND="${DEPEND}
	vala? ( $(vala_depend) )
"
BDEPEND="
	dev-util/gdbus-codegen
	dev-util/glib-utils
	sys-devel/gettext
	verify-sig? ( >=sec-keys/openpgp-keys-phosh-2025 )
"

VERIFY_SIG_OPENPGP_KEY_PATH="/usr/share/openpgp-keys/phosh.asc"

src_prepare() {
	use vala && vala_setup
	default
}

src_configure() {
	local emesonargs=(
		-Ddaemon=true
		-Dtests=true
		-Dsystemd_user_unit_dir="$(systemd_get_userunitdir)"
		$(meson_feature introspection)
		$(meson_use vala vapi)
	)
	meson_src_configure
}

src_install() {
	meson_src_install

	find "${ED}"/usr/$(get_libdir) -name "*.a" -delete || die
}
