# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	anstream@1.0.0
	anstyle-parse@1.0.0
	anstyle-query@1.1.5
	anstyle-wincon@3.0.11
	anstyle@1.0.14
	async-channel@2.5.0
	autocfg@1.5.1
	bitflags@2.13.2
	bstr@1.13.1
	cairo-rs@0.21.5
	cairo-sys-rs@0.21.5
	cfg-expr@0.20.9
	clap@4.6.7
	clap_builder@4.6.7
	clap_derive@4.6.7
	clap_lex@1.1.1
	colorchoice@1.0.5
	concurrent-queue@2.5.0
	crossbeam-utils@0.8.23
	equivalent@1.0.2
	event-listener-strategy@0.5.4
	event-listener@5.4.2
	field-offset@0.3.6
	futures-channel@0.3.34
	futures-core@0.3.34
	futures-executor@0.3.34
	futures-io@0.3.34
	futures-macro@0.3.34
	futures-task@0.3.34
	futures-util@0.3.34
	gdk-pixbuf-sys@0.21.5
	gdk-pixbuf@0.21.5
	gdk4-sys@0.10.3
	gdk4@0.10.3
	gio-sys@0.21.5
	gio@0.21.5
	glib-macros@0.21.5
	glib-sys@0.21.5
	glib@0.21.5
	gobject-sys@0.21.5
	graphene-rs@0.21.5
	graphene-sys@0.21.5
	gsk4-sys@0.10.3
	gsk4@0.10.3
	gtk4-macros@0.10.3
	gtk4-sys@0.10.3
	gtk4@0.10.3
	hashbrown@0.17.1
	heck@0.5.0
	indexmap@2.14.2
	is_terminal_polyfill@1.70.2
	libc@0.2.189
	memchr@2.8.3
	memoffset@0.9.1
	normpath@1.5.1
	once_cell_polyfill@1.70.2
	opener@0.8.5
	pango-sys@0.21.5
	pango@0.21.5
	parking@2.2.1
	pin-project-lite@0.2.17
	pkg-config@0.3.34
	proc-macro-crate@3.5.0
	proc-macro2@1.0.107
	quote@1.0.47
	regex-automata@0.4.18
	rustc_version@0.4.1
	semver@1.0.28
	serde_core@1.0.229
	serde_derive@1.0.229
	serde_spanned@1.1.1
	slab@0.4.12
	smallvec@1.16.1
	strsim@0.11.1
	syn@2.0.119
	syn@3.0.5
	system-deps@7.0.8
	target-lexicon@0.13.5
	toml@1.1.6+spec-1.1.0
	toml_datetime@1.1.1+spec-1.1.0
	toml_edit@0.25.15+spec-1.1.0
	toml_parser@1.1.3+spec-1.1.0
	toml_writer@1.1.2+spec-1.1.0
	unicode-ident@1.0.24
	utf8parse@0.2.2
	version-compare@0.2.1
	windows-link@0.2.1
	windows-sys@0.61.2
	winnow@1.0.4
"

RUST_MIN_VER="1.85.0"

inherit cargo

DESCRIPTION="Drag and Drop files to and from the terminal"
HOMEPAGE="https://github.com/nik012003/ripdrag"
SRC_URI="
	https://github.com/nik012003/ripdrag/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="GPL-3"
# Dependent crate licenses
LICENSE+=" Apache-2.0-with-LLVM-exceptions MIT Unicode-3.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/glib:2
	>=gui-libs/gtk-4.8:4
	media-libs/graphene
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/pango
"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	default
	sed -i '/^strip = true/d' Cargo.toml || die
}

src_install() {
	cargo_src_install
	einstalldocs
}
