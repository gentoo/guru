# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	anes-0.1.6
	anstream-0.2.6
	anstyle-0.3.5
	anstyle-parse-0.1.1
	anstyle-wincon-0.2.0
	anyhow-1.0.70
	atty-0.2.14
	autocfg-1.1.0
	bitflags-1.3.2
	bumpalo-3.12.0
	cast-0.3.0
	cc-1.0.79
	cfg-if-1.0.0
	ciborium-0.2.0
	ciborium-io-0.2.0
	ciborium-ll-0.2.0
	clap-3.2.23
	clap-4.2.1
	clap_builder-4.2.1
	clap_derive-4.2.0
	clap_lex-0.2.4
	clap_lex-0.4.1
	concolor-override-1.0.0
	concolor-query-0.3.3
	criterion-0.4.0
	criterion-plot-0.5.0
	crossbeam-channel-0.5.8
	crossbeam-deque-0.8.3
	crossbeam-epoch-0.9.14
	crossbeam-utils-0.8.15
	crossterm-0.26.1
	crossterm_winapi-0.9.0
	dirs-next-2.0.0
	dirs-sys-next-0.1.2
	either-1.8.1
	errno-0.3.1
	errno-dragonfly-0.1.2
	etcetera-0.4.0
	flume-0.10.14
	getrandom-0.2.9
	half-1.8.2
	hashbrown-0.12.3
	heck-0.4.1
	hermit-abi-0.1.19
	hermit-abi-0.2.6
	hermit-abi-0.3.1
	indexmap-1.9.3
	io-lifetimes-1.0.10
	is-terminal-0.4.7
	itertools-0.10.5
	itoa-1.0.6
	js-sys-0.3.61
	lazy_static-1.4.0
	libc-0.2.141
	libmimalloc-sys-0.1.32
	linux-raw-sys-0.3.1
	lock_api-0.4.9
	log-0.4.17
	memchr-2.5.0
	memoffset-0.8.0
	mimalloc-0.1.36
	mio-0.8.6
	num-traits-0.2.15
	num_cpus-1.15.0
	once_cell-1.17.1
	oorandom-11.1.3
	os_str_bytes-6.5.0
	parking_lot-0.12.1
	parking_lot_core-0.9.7
	plotters-0.3.4
	plotters-backend-0.3.4
	plotters-svg-0.3.3
	proc-macro2-1.0.56
	quote-1.0.26
	rayon-1.7.0
	rayon-core-1.11.0
	redox_syscall-0.2.16
	redox_users-0.4.3
	regex-1.7.3
	regex-syntax-0.6.29
	rustix-0.37.11
	ryu-1.0.13
	same-file-1.0.6
	scopeguard-1.1.0
	serde-1.0.159
	serde_derive-1.0.159
	serde_json-1.0.95
	serde_spanned-0.6.1
	signal-hook-0.3.15
	signal-hook-mio-0.2.3
	signal-hook-registry-1.4.1
	smallvec-1.10.0
	spin-0.9.8
	strsim-0.10.0
	syn-1.0.109
	syn-2.0.13
	terminal_size-0.2.6
	textwrap-0.16.0
	thiserror-1.0.40
	thiserror-impl-1.0.40
	tincture-1.0.0
	tinytemplate-1.2.1
	toml-0.7.3
	toml_datetime-0.6.1
	toml_edit-0.19.8
	unicode-ident-1.0.8
	unicode-width-0.1.10
	utf8parse-0.2.1
	walkdir-2.3.3
	wasi-0.11.0+wasi-snapshot-preview1
	wasm-bindgen-0.2.84
	wasm-bindgen-backend-0.2.84
	wasm-bindgen-macro-0.2.84
	wasm-bindgen-macro-support-0.2.84
	wasm-bindgen-shared-0.2.84
	web-sys-0.3.61
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	windows-sys-0.45.0
	windows-sys-0.48.0
	windows-targets-0.42.2
	windows-targets-0.48.0
	windows_aarch64_gnullvm-0.42.2
	windows_aarch64_gnullvm-0.48.0
	windows_aarch64_msvc-0.42.2
	windows_aarch64_msvc-0.48.0
	windows_i686_gnu-0.42.2
	windows_i686_gnu-0.48.0
	windows_i686_msvc-0.42.2
	windows_i686_msvc-0.48.0
	windows_x86_64_gnu-0.42.2
	windows_x86_64_gnu-0.48.0
	windows_x86_64_gnullvm-0.42.2
	windows_x86_64_gnullvm-0.48.0
	windows_x86_64_msvc-0.42.2
	windows_x86_64_msvc-0.48.0
	winnow-0.4.1
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
