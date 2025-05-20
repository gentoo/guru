# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson systemd verify-sig xdg

DESCRIPTION="Phosh portal backend for xdg-desktop-portal"
HOMEPAGE="https://gitlab.gnome.org/guidog/xdg-desktop-portal-phosh"
SRC_URI="https://sources.phosh.mobi/releases/${PN}/${P}.tar.xz
	verify-sig? ( https://sources.phosh.mobi/releases/${PN}/${P}.tar.xz.asc )"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	>=dev-libs/glib-2.76:2
	>=gnome-base/gnome-desktop-43:4
	>=gnome-base/gsettings-desktop-schemas-47
	>=gui-libs/gtk-4.12:4[wayland]
	>=gui-libs/libadwaita-1.6:1
	media-libs/fontconfig:1.0
	phosh-base/pfs
	sys-apps/dbus
	>=sys-apps/xdg-desktop-portal-1.19.1
"
RDEPEND="${DEPEND}
	!<phosh-base/phosh-shell-0.44.0
"
BDEPEND="
	dev-libs/glib:2
	dev-util/gdbus-codegen
	sys-devel/gettext
	virtual/pkgconfig
	verify-sig? ( sec-keys/openpgp-keys-phosh )
"

VERIFY_SIG_OPENPGP_KEY_PATH="/usr/share/openpgp-keys/phosh.asc"

src_configure() {
	local emesonargs=(
		-Dsystemd_user_unit_dir="$(systemd_get_userunitdir)"
	)
	meson_src_configure
}
