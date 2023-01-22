# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	anyhow-1.0.58
	atty-0.2.14
	autocfg-1.1.0
	bitflags-1.3.2
	bstr-0.2.17
	bumpalo-3.10.0
	cast-0.3.0
	cc-1.0.73
	cfg-if-1.0.0
	clap-2.34.0
	clap-3.2.14
	clap_derive-3.2.7
	clap_lex-0.2.4
	criterion-0.3.6
	criterion-plot-0.4.5
	crossbeam-channel-0.5.6
	crossbeam-deque-0.8.2
	crossbeam-epoch-0.9.10
	crossbeam-utils-0.8.11
	crossterm-0.24.0
	crossterm_winapi-0.9.0
	csv-1.1.6
	csv-core-0.1.10
	dirs-next-2.0.0
	dirs-sys-next-0.1.2
	either-1.7.0
	etcetera-0.4.0
	flume-0.10.14
	getrandom-0.2.7
	half-1.8.2
	hashbrown-0.12.3
	heck-0.4.0
	hermit-abi-0.1.19
	indexmap-1.9.1
	itertools-0.10.3
	itoa-0.4.8
	itoa-1.0.2
	js-sys-0.3.58
	lazy_static-1.4.0
	libc-0.2.126
	libmimalloc-sys-0.1.25
	lock_api-0.4.7
	log-0.4.17
	memchr-2.5.0
	memoffset-0.6.5
	mimalloc-0.1.29
	mio-0.8.4
	num-traits-0.2.15
	num_cpus-1.13.1
	once_cell-1.13.0
	oorandom-11.1.3
	os_str_bytes-6.2.0
	parking_lot-0.12.1
	parking_lot_core-0.9.3
	plotters-0.3.2
	plotters-backend-0.3.4
	plotters-svg-0.3.2
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro2-1.0.40
	quote-1.0.20
	rayon-1.5.3
	rayon-core-1.9.3
	redox_syscall-0.2.15
	redox_users-0.4.3
	regex-1.6.0
	regex-automata-0.1.10
	regex-syntax-0.6.27
	ryu-1.0.10
	same-file-1.0.6
	scopeguard-1.1.0
	serde-1.0.140
	serde_cbor-0.11.2
	serde_derive-1.0.140
	serde_json-1.0.82
	signal-hook-0.3.14
	signal-hook-mio-0.2.3
	signal-hook-registry-1.4.0
	smallvec-1.9.0
	spin-0.9.4
	strsim-0.10.0
	syn-1.0.98
	termcolor-1.1.3
	terminal_size-0.1.17
	textwrap-0.11.0
	textwrap-0.15.0
	thiserror-1.0.31
	thiserror-impl-1.0.31
	tincture-1.0.0
	tinytemplate-1.2.1
	toml-0.5.9
	unicode-ident-1.0.2
	unicode-width-0.1.9
	version_check-0.9.4
	walkdir-2.3.2
	wasi-0.11.0+wasi-snapshot-preview1
	wasm-bindgen-0.2.81
	wasm-bindgen-backend-0.2.81
	wasm-bindgen-macro-0.2.81
	wasm-bindgen-macro-support-0.2.81
	wasm-bindgen-shared-0.2.81
	web-sys-0.3.58
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	windows-sys-0.36.1
	windows_aarch64_msvc-0.36.1
	windows_i686_gnu-0.36.1
	windows_i686_msvc-0.36.1
	windows_x86_64_gnu-0.36.1
	windows_x86_64_msvc-0.36.1
"

inherit cargo

DESCRIPTION="An over-engineered rewrite of pipes.sh in Rust"
HOMEPAGE="https://github.com/lhvy/pipes-rs"
SRC_URI="
	https://github.com/lhvy/pipes-rs/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris)
"

LICENSE="Apache-2.0 MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	cargo_src_install --path ./crates/${PN}
}

QA_FLAGS_IGNORED="usr/bin/${PN}"
