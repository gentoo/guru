# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils meson verify-sig xdg

DESCRIPTION="Mobile Settings App for phosh and related components"
HOMEPAGE="https://gitlab.gnome.org/guidog/phosh-mobile-settings"
SRC_URI="https://sources.phosh.mobi/releases/${PN}/${P}.tar.xz
	verify-sig? ( https://sources.phosh.mobi/releases/${PN}/${P}.tar.xz.asc )"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-libs/glib-2.74:2
	>=dev-libs/json-glib-1.6.2
	>=dev-libs/wayland-1.14
	>=gui-libs/gtk-4.12.5:4[wayland]
	>=gui-libs/libadwaita-1.4:1
	media-libs/gsound
	phosh-base/phosh-shell
	sys-apps/lm-sensors:=
"
DEPEND="${RDEPEND}
	>=dev-libs/wayland-protocols-1.12
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

src_install() {
	meson_src_install --skip-subprojects gmobile
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
