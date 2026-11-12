# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RUST_MIN_VER="1.85.0"

CRATES=" "

inherit cargo

DESCRIPTION="An SVG rendering library"
HOMEPAGE="https://github.com/linebender/resvg"
SRC_URI="
	https://github.com/linebender/resvg/releases/download/v${PV}/${P}.tar.xz
"

LICENSE="|| ( Apache-2.0 MIT )"
# Dependent crate licenses
LICENSE+=" BSD-2 BSD ISC MIT Unicode-3.0 ZLIB"
SLOT="0"
KEYWORDS="~amd64"

pkg_setup() {
	QA_SONAME="usr/$(get_libdir)/libresvg.so"
	QA_FLAGS_IGNORED="
		usr/$(get_libdir)/libresvg.so
		usr/bin/resvg
		usr/bin/usvg
	"
	rust_pkg_setup
}

src_compile() {
	cargo_src_compile --workspace
}

src_install() {
	cargo_src_install --path ./crates/resvg
	cargo_src_install --path ./crates/usvg
	dolib.so $(cargo_target_dir)/libresvg.so
	doheader ./crates/c-api/resvg.h
}
