# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module git-r3

DESCRIPTION="Multi-Purpose Launcher with a lot of features. Highly Customizable and fast"
HOMEPAGE="https://github.com/abenz1267/walker"
EGIT_REPO_URI="https://github.com/abenz1267/${PN}"

LICENSE="MIT"
SLOT="0"

RDEPEND="
	dev-libs/glib:2
	gui-libs/gtk:4
	>=gui-libs/gtk4-layer-shell-1.0.4
	dev-libs/gobject-introspection
	media-libs/graphene
	media-libs/vips:=
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/pango
"
DEPEND="${RDEPEND}"
BDEPEND="
	>=dev-libs/glib-2.80.0[introspection]
"

src_unpack() {
    git-r3_src_unpack
    go-module_live_vendor
}

src_compile() {
	cd "${S}"/cmd || die
	ego build -o walker
}

src_install() {
	dobin cmd/"${PN}"
}
