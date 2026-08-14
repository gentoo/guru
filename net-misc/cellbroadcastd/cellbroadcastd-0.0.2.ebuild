# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson systemd verify-sig

DESCRIPTION="DBus service for cellular broadcast messages"
HOMEPAGE="https://gitlab.freedesktop.org/devrtz/cellbroadcastd"
SRC_URI="https://sources.phosh.mobi/releases/${PN}/cbd-${PV}.tar.xz
	verify-sig? ( https://sources.phosh.mobi/releases/${PN}/cbd-${PV}.tar.xz.asc )"
S="${WORKDIR}/cbd-${PV}"

LICENSE="GPL-3+ LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+introspection"

DEPEND="
	>=dev-libs/glib-2.76.0:2
	>=dev-libs/gmobile-0.4.0
	gnome-base/gsettings-desktop-schemas
	net-misc/mobile-broadband-provider-info
	>=net-misc/modemmanager-1.24.0:=
	sys-apps/dbus
	introspection? ( dev-libs/gobject-introspection )
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-util/gdbus-codegen
	dev-util/glib-utils
	sys-devel/gettext
	verify-sig? ( sec-keys/openpgp-keys-phosh )
"

VERIFY_SIG_OPENPGP_KEY_PATH="/usr/share/openpgp-keys/phosh.asc"

src_configure() {
	local emesonargs=(
		-Ddaemon=true
		-Dtests=true
		-Dsystemd_user_unit_dir="$(systemd_get_userunitdir)"
		$(meson_feature introspection)
	)
	meson_src_configure
}

src_install() {
	meson_src_install

	find "${ED}"/usr/$(get_libdir) -name "*.a" -delete || die
}
