# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson xdg gnome2-utils vala

DESCRIPTION="A GTK4 time tracker for tasks"
HOMEPAGE="https://apps.gnome.org/app/io.github.lainsce.Khronos"
SRC_URI="https://github.com/lainsce/khronos/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IDEPEND="
		>=gui-libs/gtk-4.6
		>=gui-libs/libadwaita-1
		>=dev-libs/libgee-0.20.6
		>=dev-libs/json-glib-1.6.6-r1
"
DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="
		app-alternatives/ninja
		>=dev-lang/vala-0.56.8
		>=dev-build/meson-1.1.1
		$(vala_depend)
"

src_prepare() {
	default
	vala_setup
	xdg_environment_reset

	sed -i \
		-e '/^gnome.post_install(/,/)/d' \
		meson.build \
		|| die
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
