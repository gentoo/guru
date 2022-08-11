# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson gnome2-utils xdg-utils

DESCRIPTION="Tools to access devices with LXI"
HOMEPAGE="https://github.com/lxi-tools/lxi-tools"
SRC_URI="https://github.com/lxi-tools/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="bash-completion +gui"

RDEPEND="
	bash-completion? ( >=app-shells/bash-completion-2.11 )
	>=sys-libs/readline-8.1_p2
	>=dev-lang/lua-5.3.6-r2:5.3
	>=sci-electronics/liblxi-1.13
	gui? (
		>=dev-libs/glib-2.70
		>=gui-libs/gtk-4.5.0
		>=gui-libs/gtksourceview-5.3.3
		>=gui-libs/libadwaita-1.0.1
	)
"
DEPEND="${RDEPEND}"

src_configure() {
	local emesonargs=(
		$(meson_use gui)
	)
	meson_src_configure
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_icon_cache_update
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_icon_cache_update
}
