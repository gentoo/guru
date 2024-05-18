# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2-utils xdg meson vala

DESCRIPTION="Native Linux App for UI and UX Design built in Vala and GTK."
HOMEPAGE="https://github.com/akiraux/Akira"
if [[ "${PV}" == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="git://github.com/akiraux/${PN}.git"
else
	SRC_URI="https://github.com/akiraux/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${P^}"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-libs/gobject-introspection
	>=dev-libs/granite-5.3.0
	app-arch/libarchive
	dev-libs/json-glib
	dev-libs/libgee
	dev-libs/libxml2
	sys-devel/gettext
	x11-libs/goocanvas:3.0
	x11-libs/gtksourceview:3.0"
RDEPEND="${DEPEND}"

src_prepare(){
	vala_src_prepare
	default
}

src_install(){
	meson_src_install
	dosym ../../usr/bin/com.github.akiraux.akira /usr/bin/akira
}

pkg_preinst() {
	xdg_pkg_preinst
	gnome2_schemas_savelist
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_savelist
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_savelist
}
