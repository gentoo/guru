# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils meson xdg

MY_P="${PN}-v${PV}"
DESCRIPTION="Introduction to phosh on smartphones"
HOMEPAGE="https://gitlab.gnome.org/guidog/phosh-tour"
SRC_URI="https://gitlab.gnome.org/guidog/${PN}/-/archive/v${PV}/${MY_P}.tar.bz2"
S="${WORKDIR}/${MY_P}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/glib:2
	>=gui-libs/gtk-4.4:4
	>=gui-libs/libadwaita-1.1:1
"
RDEPEND="${DEPEND}"
BDEPEND="sys-devel/gettext"

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

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
