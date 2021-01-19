# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit vala meson gnome2-utils xdg

DESCRIPTION="Mastodon client written in GTK3"
HOMEPAGE="https://github.com/bleakgrey/tootle"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/bleakgrey/${PN}.git"
else
	MY_PV="${PV/_/-}"
	SRC_URI="https://github.com/bleakgrey/${PN}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}-${MY_PV}"
fi

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	dev-libs/glib:2
	dev-libs/json-glib
	dev-libs/libgee:0.8
	gui-libs/libhandy:1
	net-libs/libsoup:2.4
	x11-libs/gtk+:3
"
DEPEND="
	${RDEPEND}
"

src_prepare() {
	xdg_src_prepare
	vala_src_prepare
	default
}

pkg_preinst() {
	gnome2_schemas_savelist
	xdg_pkg_preinst
}

pkg_postinst() {
	gnome2_gconf_install
	gnome2_schemas_update
	xdg_pkg_postinst
}

pkg_postrm() {
	gnome2_gconf_uninstall
	gnome2_schemas_update
	xdg_pkg_postrm
}
