# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES=""
inherit cargo gnome2-utils meson xdg

DESCRIPTION="GTK 4 Gemini browser written in Rust"
HOMEPAGE="
	https://ranfdev.com/projects/geopard/
	https://github.com/ranfdev/Geopard
"
SRC_URI="https://github.com/ranfdev/${PN}/releases/download/v${PV}/${P}.tar.xz"

LICENSE="GPL-3"
# Dependent crate licenses
LICENSE+=" Apache-2.0-with-LLVM-exceptions BSD MIT Unicode-DFS-2016"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug"

DEPEND="
	>=dev-libs/glib-2.66:2
	>=gui-libs/gtk-4.12:4
	gui-libs/libadwaita:1
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/pango
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-libs/glib:2
	dev-util/blueprint-compiler
	sys-devel/gettext
	virtual/pkgconfig
"

BUILD_DIR="${S}/build"
ECARGO_HOME="${BUILD_DIR}/cargo-home"

QA_FLAGS_IGNORED="usr/bin/geopard"

src_prepare() {
	default

	sed -e "s:get_option('profile.*:$(usex debug false true):" \
		-i src/meson.build || die
}

src_configure() {
	unset RUSTC_WRAPPER
	local emesonargs=(
		-Doffline=true
	)

	meson_src_configure
}

src_compile() {
	cargo_env meson_src_compile
}

src_test() {
	# No meaningful tests
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
