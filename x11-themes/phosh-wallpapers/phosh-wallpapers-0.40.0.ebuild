# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils meson verify-sig xdg

DESCRIPTION="Phosh wallpapers and other artwork"
HOMEPAGE="https://gitlab.gnome.org/guidog/phosh-wallpapers"
SRC_URI="https://sources.phosh.mobi/releases/${PN}/${P}.tar.xz
	verify-sig? ( https://sources.phosh.mobi/releases/${PN}/${P}.tar.xz.asc )"

LICENSE="CC0-1.0 CC-BY-SA-4.0 GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	verify-sig? (
		sec-keys/openpgp-keys-phosh
	)
"

VERIFY_SIG_OPENPGP_KEY_PATH="/usr/share/openpgp-keys/phosh.asc"

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
