# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils meson verify-sig xdg

DESCRIPTION="Introduction to phosh on smartphones"
HOMEPAGE="https://gitlab.gnome.org/guidog/phosh-tour"
SRC_URI="https://sources.phosh.mobi/releases/${PN}/${P}.tar.xz
	verify-sig? ( https://sources.phosh.mobi/releases/${PN}/${P}.tar.xz.asc )"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	>=dev-libs/glib-2.74:2
	>=gui-libs/gtk-4.12:4
	>=gui-libs/libadwaita-1.4:1
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-libs/libxml2
	sys-devel/gettext
	verify-sig? (
		sec-keys/openpgp-keys-phosh
	)
"

VERIFY_SIG_OPENPGP_KEY_PATH="/usr/share/openpgp-keys/phosh.asc"

QA_DESKTOP_FILE="usr/share/applications/mobi.phosh.PhoshTour.desktop"

src_configure() {
	local emesonargs=(
		-Dbrand="smartphone"
		-Dvendor="Gentoo"
	)
	meson_src_configure
}

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
