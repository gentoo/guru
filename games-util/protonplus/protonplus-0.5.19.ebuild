# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils meson vala xdg

DESCRIPTION="A modern compatibility tools manager"
HOMEPAGE="https://github.com/Vysp3r/ProtonPlus"
SRC_URI="https://github.com/Vysp3r/ProtonPlus/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/ProtonPlus-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	$(vala_depend)
	dev-libs/appstream-glib
	dev-util/desktop-file-utils
	sys-devel/gettext
	virtual/pkgconfig
"

DEPEND="
	>=gui-libs/libadwaita-1.6
	app-arch/libarchive
	dev-libs/glib:2
	dev-libs/json-glib
	dev-libs/libgee:0.8
	gui-libs/gtk:4
	net-libs/libsoup:3.0
"

RDEPEND="${DEPEND}"

src_prepare() {
	default
	vala_setup
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
