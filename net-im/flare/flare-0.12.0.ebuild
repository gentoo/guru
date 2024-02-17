# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils meson xdg

PKG_ID=112823190
DESCRIPTION="Chat with your friends on Signal"
HOMEPAGE="
	https://mobile.schmidhuberj.de/flare
	https://gitlab.com/schmiddi-on-mobile/flare
"
SRC_URI="https://gitlab.com/schmiddi-on-mobile/${PN}/-/package_files/${PKG_ID}/download -> ${P}.tar.xz"
BUILD_DIR="${S}/build"

LICENSE="AGPL-3"
# Dependent crate licenses
LICENSE+="
	|| ( 0BSD Apache-2.0 MIT )
	|| ( Apache-2.0 Apache-2.0-with-LLVM-exceptions MIT )
	|| ( Apache-2.0 BSD MIT )
	|| ( Apache-2.0 BSD-1 MIT )
	|| ( Apache-2.0 Boost-1.0 )
	|| ( Apache-2.0 CC0-1.0 )
	|| ( Apache-2.0 CC0-1.0 MIT-0 )
	|| ( Apache-2.0 ISC MIT )
	|| ( Apache-2.0 MIT )
	|| ( Apache-2.0 MIT ZLIB )
	|| ( MIT Unlicense )
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD BSD-2 ISC MIT Unicode-DFS-2016 ZLIB openssl
"

SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	app-text/libspelling:1
	>=dev-libs/glib-2.66:2
	>=gui-libs/gtk-4.12:4[X]
	gui-libs/gtksourceview:5
	>=gui-libs/libadwaita-1.4:1
	media-libs/graphene
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/pango
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-libs/glib:2
	dev-util/blueprint-compiler
	sys-devel/gettext
	virtual/rust
"

QA_FLAGS_IGNORED="usr/bin/${PN}"

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
