# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	ansi-to-tui-0.4.1
	anyhow-1.0.51
	assert_cmd-2.0.2
	atty-0.2.14
	autocfg-1.0.1
	bitflags-1.3.2
	bstr-0.2.17
	bumpalo-3.8.0
	cassowary-0.3.0
	cast-0.2.7
	cc-1.0.72
	cfg-if-1.0.0
	chrono-0.4.19
	clap-2.34.0
	criterion-0.3.5
	criterion-plot-0.4.4
	crossbeam-channel-0.5.1
	crossbeam-deque-0.8.1
	crossbeam-epoch-0.9.5
	crossbeam-utils-0.8.5
	crossterm-0.20.0
	crossterm-0.22.1
	crossterm_winapi-0.8.0
	crossterm_winapi-0.9.0
	csv-1.1.6
	csv-core-0.1.10
	difflib-0.4.0
	dirs-4.0.0
	dirs-sys-0.3.6
	doc-comment-0.3.3
	dtoa-0.4.8
	either-1.6.1
	erased-serde-0.3.16
	getrandom-0.2.3
	half-1.8.2
	hashbrown-0.11.2
	hermit-abi-0.1.19
	humansize-1.1.1
	indexmap-1.7.0
	instant-0.1.12
	itertools-0.10.3
	itoa-0.4.8
	js-sys-0.3.55
	lazy_static-1.4.0
	libc-0.2.109
	linked-hash-map-0.5.4
	lock_api-0.4.5
	log-0.4.14
	lua-src-543.1.0
	luajit-src-210.3.2+resty1085a4d
	memchr-2.4.1
	memoffset-0.6.5
	mime-0.3.16
	mime_guess-2.0.3
	mio-0.7.14
	miow-0.3.7
	mlua-0.7.0
	natord-1.0.9
	ntapi-0.3.6
	num-integer-0.1.44
	num-traits-0.2.14
	num_cpus-1.13.0
	once_cell-1.8.0
	oorandom-11.1.3
	parking_lot-0.11.2
	parking_lot_core-0.8.5
	pkg-config-0.3.24
	plotters-0.3.1
	plotters-backend-0.3.2
	plotters-svg-0.3.1
	predicates-2.1.0
	predicates-core-1.0.2
	predicates-tree-1.0.4
	proc-macro2-1.0.33
	quote-1.0.10
	rayon-1.5.1
	rayon-core-1.9.1
	redox_syscall-0.2.10
	redox_users-0.4.0
	regex-1.5.4
	regex-automata-0.1.10
	regex-syntax-0.6.25
	rustc-hash-1.1.0
	rustc_version-0.4.0
	ryu-1.0.7
	same-file-1.0.6
	scopeguard-1.1.0
	semver-1.0.4
	serde-1.0.131
	serde_cbor-0.11.2
	serde_derive-1.0.131
	serde_json-1.0.72
	serde_yaml-0.8.21
	signal-hook-0.3.12
	signal-hook-mio-0.2.1
	signal-hook-registry-1.4.0
	smallvec-1.7.0
	syn-1.0.82
	termtree-0.2.3
	textwrap-0.11.0
	time-0.1.44
	tinytemplate-1.2.1
	tui-0.16.0
	tui-input-0.1.2
	unicase-2.6.0
	unicode-segmentation-1.8.0
	unicode-width-0.1.9
	unicode-xid-0.2.2
	version_check-0.9.3
	wait-timeout-0.2.0
	walkdir-2.3.2
	wasi-0.10.0+wasi-snapshot-preview1
	wasm-bindgen-0.2.78
	wasm-bindgen-backend-0.2.78
	wasm-bindgen-macro-0.2.78
	wasm-bindgen-macro-support-0.2.78
	wasm-bindgen-shared-0.2.78
	web-sys-0.3.55
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	yaml-rust-0.4.5
"

inherit cargo flag-o-matic desktop

DESCRIPTION="A hackable, minimal, fast TUI file explorer"
# Double check the homepage as the cargo_metadata crate
# does not provide this value so instead repository is used
HOMEPAGE="https://github.com/sayanarijit/xplr"
SRC_URI="
	https://github.com/sayanarijit/xplr/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris)
"

LICENSE="
	|| ( Apache-2.0 )
	|| ( BSD )
	|| ( MIT )
	|| ( Unlicense )
	Apache-2.0
	BSD
	MIT
	Unlicense
"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-vcs/git
	sys-devel/make
	sys-devel/gcc
"

QA_FLAGS_IGNORED="usr/bin/.*"

src_configure() {
	cargo_src_configure --locked --bin xplr
	sed "s:\$(CROSS)::g" -i ../cargo_home/gentoo/luajit-src-210.3.2+resty1085a4d/luajit2/src/Makefile || die

}

src_compile() {
	cargo_src_compile
}

src_install() {
	dodoc RELEASE.md README.md CODE_OF_CONDUCT.md CONTRIBUTING.md
	dobin target/release/xplr
}
