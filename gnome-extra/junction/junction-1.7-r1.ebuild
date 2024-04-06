# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils meson

TROLL_COMMIT="94ced56f1b08e6955f6c8325a04c74736d39b823"
DESCRIPTION="Application/browser chooser"
HOMEPAGE="
	https://apps.gnome.org/app/re.sonny.Junction/
	https://github.com/sonnyp/Junction
"
SRC_URI="
	https://github.com/sonnyp/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/sonnyp/troll/archive/${TROLL_COMMIT}.tar.gz -> troll-${P}.tar.gz
"
S="${WORKDIR}/${PN^}-${PV}"

LICENSE="GPL-3+"
KEYWORDS="~amd64"
SLOT="0"

DEPEND="
	dev-libs/gjs
	dev-libs/glib:2
"
RDEPEND="${DEPEND}
	dev-libs/gobject-introspection
	dev-libs/libportal[introspection,gtk]
	gui-libs/gtk:4[introspection]
	gui-libs/libadwaita:1[introspection]
	net-libs/libsoup:3.0[introspection]
"
BDEPEND="
	dev-util/blueprint-compiler
	sys-devel/gettext
"

src_prepare() {
	default

	rmdir "${S}"/troll || die
	mv "${WORKDIR}"/troll-${TROLL_COMMIT} "${S}"/troll || die

	# https://github.com/sonnyp/Junction/issues/115
	sed \
		's#XDG_DATA_DIRS=\(.*\) gjs#XDG_DATA_DIRS=\1:/usr/local/share/:/usr/share/ gjs#' \
		-i src/bin.js || die
}

# only data files validators, skip them
src_test() {
	:
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
	gnome2_schemas_update
}
