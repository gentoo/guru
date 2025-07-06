# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils meson verify-sig xdg

DESCRIPTION="Phosh and related settings for mobile"
HOMEPAGE="https://gitlab.gnome.org/guidog/phosh-mobile-settings"
SRC_URI="https://sources.phosh.mobi/releases/${PN}/${P}.tar.xz
	verify-sig? ( https://sources.phosh.mobi/releases/${PN}/${P}.tar.xz.asc )"

LICENSE="GPL-2+ GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

COMMON_DEPEND="
	>=dev-libs/glib-2.76:2
	>=dev-libs/gmobile-0.2.1
	>=dev-libs/json-glib-1.6.2
	>=dev-libs/feedbackd-0.8.0
	>=dev-libs/libportal-0.9.1:=[gtk]
	>=dev-libs/wayland-1.14
	>=gnome-base/gnome-desktop-44:4=
	>=gui-libs/gtk-4.12.5:4[wayland]
	>=gui-libs/libadwaita-1.5:1
	media-libs/gsound
	>=media-libs/libpulse-12.99.3[glib]
	>=phosh-base/phosh-shell-0.40.0
	sys-apps/dbus
	sys-apps/lm-sensors:=
"
DEPEND="${COMMON_DEPEND}
	>=dev-libs/wayland-protocols-1.12
"
RDEPEND="${COMMON_DEPEND}
	!<phosh-base/phosh-osk-stub-0.42.0
	>=gui-wm/phoc-0.34.0
	|| (
		>=phosh-base/xdg-desktop-portal-phosh-0.46.0
		<phosh-base/phosh-shell-0.44.0
	)
"
BDEPEND="
	dev-libs/glib:2
	dev-util/gdbus-codegen
	dev-util/glib-utils
	dev-util/wayland-scanner
	sys-devel/gettext
	verify-sig? ( sec-keys/openpgp-keys-phosh )
"

VERIFY_SIG_OPENPGP_KEY_PATH="/usr/share/openpgp-keys/phosh.asc"

QA_DESKTOP_FILE="usr/share/applications/mobi.phosh.MobileSettings.desktop"

src_test() {
	# No useful tests
	:
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
