# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python{3_12,3_13} )
LUA_COMPAT=( lua5-{1..4} )
inherit meson python-any-r1 lua-single gnome2-utils bash-completion-r1

DESCRIPTION="Tools to access devices with LXI"
HOMEPAGE="https://github.com/lxi-tools/lxi-tools"
SRC_URI="https://github.com/lxi-tools/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="bash-completion +gui"

REQUIRED_USE="${LUA_REQUIRED_USE}"
RDEPEND="
	bash-completion? ( >=app-shells/bash-completion-2.11 )
	>=sys-libs/readline-8.1_p2
	${LUA_DEPS}
	>=sci-electronics/liblxi-1.13
	gui? (
		>=dev-libs/glib-2.70
		>=gui-libs/gtk-4.6.0
		>=gui-libs/gtksourceview-5.4.0
		>=gui-libs/libadwaita-1.2
		>=dev-libs/json-glib-1.4
	)
"
DEPEND="${RDEPEND}"
BDEPEND="
	${PYTHON_DEPS}
	virtual/pkgconfig
"

pkg_setup() {
	python-any-r1_pkg_setup
	lua-single_pkg_setup
}

src_configure() {
	# fix lua dependency string in meson-build
	sed -i 's/lua-/lua/g' "${S}"/src/meson.build || die

	local emesonargs=(
		$(meson_use gui)
		-Dbashcompletiondir="$(get_bashcompdir)"
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
