# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	ahash-0.7.6
	aho-corasick-0.7.18
	ansi_term-0.11.0
	ansi_term-0.12.1
	anyhow-1.0.45
	ascii-canvas-3.0.0
	atk-0.14.0
	atk-sys-0.14.0
	atty-0.2.14
	autocfg-1.0.1
	base64-0.13.0
	beef-0.5.1
	bincode-1.3.3
	bit-set-0.5.2
	bit-vec-0.6.3
	bitflags-1.2.1
	bytes-1.1.0
	cairo-rs-0.14.9
	cairo-sys-rs-0.14.9
	cc-1.0.71
	cfg-expr-0.8.1
	cfg-if-1.0.0
	clap-2.33.3
	codemap-0.1.3
	codespan-reporting-0.11.1
	console-0.14.1
	convert_case-0.4.0
	core-foundation-sys-0.8.3
	crossbeam-channel-0.5.1
	crossbeam-deque-0.8.1
	crossbeam-epoch-0.9.5
	crossbeam-utils-0.8.5
	crunchy-0.2.2
	ctor-0.1.21
	debug_stub_derive-0.3.0
	derive_more-0.99.16
	diff-0.1.12
	dirs-next-2.0.0
	dirs-sys-next-0.1.2
	dtoa-0.4.8
	dyn-clone-1.0.4
	either-1.6.1
	ena-0.14.0
	encode_unicode-0.3.6
	env_logger-0.7.1
	extend-1.1.2
	field-offset-0.3.4
	filetime-0.2.15
	fixedbitset-0.2.0
	fsevent-sys-4.0.0
	futures-0.3.17
	futures-channel-0.3.17
	futures-core-0.3.17
	futures-executor-0.3.17
	futures-io-0.3.17
	futures-macro-0.3.17
	futures-sink-0.3.17
	futures-task-0.3.17
	futures-util-0.3.17
	gdk-0.14.3
	gdk-pixbuf-0.9.0
	gdk-pixbuf-0.14.0
	gdk-pixbuf-sys-0.10.0
	gdk-pixbuf-sys-0.14.0
	gdk-sys-0.14.0
	gdkx11-0.14.0
	gdkx11-sys-0.14.0
	gethostname-0.2.1
	getrandom-0.2.3
	gio-0.9.1
	gio-0.14.8
	gio-sys-0.10.1
	gio-sys-0.14.0
	glib-0.10.3
	glib-0.14.8
	glib-macros-0.10.1
	glib-macros-0.14.1
	glib-sys-0.10.1
	glib-sys-0.14.0
	gobject-sys-0.10.0
	gobject-sys-0.14.0
	grass-0.10.8
	gtk-0.14.3
	gtk-layer-shell-0.2.2
	gtk-layer-shell-sys-0.2.3
	gtk-sys-0.14.0
	gtk3-macros-0.14.0
	hashbrown-0.11.2
	heck-0.3.3
	hermit-abi-0.1.19
	humantime-1.3.0
	indexmap-1.7.0
	inotify-0.9.6
	inotify-sys-0.1.5
	insta-1.8.0
	instant-0.1.12
	itertools-0.9.0
	itertools-0.10.1
	itoa-0.4.8
	kqueue-1.0.4
	kqueue-sys-1.0.3
	lalrpop-0.19.6
	lalrpop-util-0.19.6
	lasso-0.5.1
	lazy_static-1.4.0
	levenshtein-1.0.5
	libc-0.2.124
	linked-hash-map-0.5.4
	lock_api-0.4.5
	log-0.4.14
	maplit-1.0.2
	memchr-2.4.1
	memoffset-0.6.4
	mio-0.7.14
	miow-0.3.7
	new_debug_unreachable-1.0.4
	nix-0.20.2
	notify-5.0.0-pre.13
	ntapi-0.3.6
	num-bigint-0.4.3
	num-integer-0.1.44
	num-rational-0.4.0
	num-traits-0.2.14
	num_cpus-1.13.0
	once_cell-1.8.0
	output_vt100-0.1.2
	pango-0.14.8
	pango-sys-0.14.0
	parking_lot-0.11.2
	parking_lot_core-0.8.5
	pest-2.1.3
	petgraph-0.5.1
	phf-0.9.0
	phf_generator-0.9.1
	phf_macros-0.9.0
	phf_shared-0.8.0
	phf_shared-0.9.0
	pico-args-0.4.2
	pin-project-lite-0.2.7
	pin-utils-0.1.0
	pkg-config-0.3.22
	ppv-lite86-0.2.15
	precomputed-hash-0.1.1
	pretty_assertions-0.7.2
	pretty_env_logger-0.4.0
	proc-macro-crate-0.1.5
	proc-macro-crate-1.1.0
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro-hack-0.5.19
	proc-macro-nested-0.1.7
	proc-macro2-1.0.32
	quick-error-1.2.3
	quote-0.3.15
	quote-1.0.10
	rand-0.8.4
	rand_chacha-0.3.1
	rand_core-0.6.3
	rand_hc-0.3.1
	rayon-1.5.1
	rayon-core-1.9.1
	redox_syscall-0.2.10
	redox_users-0.4.0
	ref-cast-1.0.6
	ref-cast-impl-1.0.6
	regex-1.5.4
	regex-syntax-0.6.25
	ron-0.6.6
	rustc_version-0.3.3
	rustversion-1.0.5
	ryu-1.0.5
	same-file-1.0.6
	scopeguard-1.1.0
	semver-0.11.0
	semver-parser-0.10.2
	serde-1.0.130
	serde_derive-1.0.130
	serde_json-1.0.68
	serde_yaml-0.8.21
	signal-hook-registry-1.4.0
	similar-1.3.0
	simple-signal-1.1.1
	siphasher-0.3.7
	slab-0.4.5
	smallvec-1.7.0
	smart-default-0.6.0
	static_assertions-1.1.0
	string_cache-0.8.2
	strsim-0.8.0
	structopt-0.3.25
	structopt-derive-0.4.18
	strum-0.18.0
	strum-0.21.0
	strum_macros-0.18.0
	strum_macros-0.21.1
	syn-0.11.11
	syn-1.0.81
	synom-0.11.3
	sysinfo-0.23.12
	system-deps-1.3.2
	system-deps-3.2.0
	term-0.7.0
	termcolor-1.1.2
	terminal_size-0.1.17
	textwrap-0.11.0
	thiserror-1.0.30
	thiserror-impl-1.0.30
	tiny-keccak-2.0.2
	tokio-1.13.0
	tokio-macros-1.5.1
	tokio-util-0.6.9
	toml-0.5.8
	ucd-trie-0.1.3
	unescape-0.1.0
	unicode-segmentation-1.8.0
	unicode-width-0.1.9
	unicode-xid-0.0.4
	unicode-xid-0.2.2
	uuid-0.8.2
	vec_map-0.8.2
	version-compare-0.0.10
	version-compare-0.0.11
	version_check-0.9.3
	wait-timeout-0.2.0
	walkdir-2.3.2
	wasi-0.10.2+wasi-snapshot-preview1
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-wsapoll-0.1.1
	winapi-x86_64-pc-windows-gnu-0.4.0
	x11-2.19.1
	x11rb-0.8.1
	yaml-rust-0.4.5

"

#   pretty-assertions-1.0.0
#   anyhow-1.0.42

inherit cargo

DESCRIPTION="Elkowars Wacky Widgets is a standalone widget system made in Rust"
HOMEPAGE="https://github.com/elkowar/eww"
SRC_URI="
	https://github.com/elkowar/eww/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris)
"

LICENSE="
	Apache-2.0
	|| ( Apache-2.0 MIT )
	|| ( Apache-2.0 BSL-1.1 )
	|| ( Artistic-2 CC0-1.0 )
	BSD
	CC0-1.0
	ISC
	MIT
	|| ( MIT Unlicense )
"
SLOT="0"
KEYWORDS="~amd64"
IUSE="wayland"

DEPEND="
	>=gui-libs/gtk-3.0
	x11-libs/pango
	x11-libs/gdk-pixbuf
	x11-libs/cairo
	>=dev-libs/glib-2.0
	sys-libs/glibc
	sys-devel/gcc
	wayland? (
	gui-libs/gtk-layer-shell
	)
"
BDEPEND="
	$DEPEND
"
RDEPEND="
	$DEPEND
"

#QA_FLAGS_IGNORED="usr/bin/.*"

src_compile() {
	use wayland && features="--no-default-features --features=wayland"
	cargo_src_compile ${features}
}

src_install() {
	dodoc README.md CHANGELOG.md
	cd target/release || die
	dobin eww
	elog "Eww wont run without a config file (usually in ~/.config/eww)."
	elog "For example configs visit https://github.com/elkowar/eww#examples"
}
