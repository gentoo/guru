# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	adler-1.0.2
	aho-corasick-0.5.3
	aho-corasick-0.7.18
	ansi_term-0.12.1
	attohttpc-0.18.0
	atty-0.2.14
	autocfg-1.1.0
	base64-0.13.0
	bitflags-1.3.2
	block-buffer-0.10.2
	bstr-0.2.17
	bumpalo-3.9.1
	bytes-1.1.0
	camino-1.0.7
	cargo-platform-0.1.2
	cargo_metadata-0.14.2
	cc-1.0.73
	cfg-if-1.0.0
	chrono-0.2.25
	ci_info-0.14.4
	clap-3.1.8
	colored-2.0.0
	core-foundation-0.9.3
	core-foundation-sys-0.8.3
	cpufeatures-0.2.2
	crc32fast-1.3.2
	crossbeam-utils-0.8.8
	crypto-common-0.1.3
	digest-0.10.3
	dirs-next-2.0.0
	dirs-sys-next-0.1.2
	duckscript-0.7.1
	duckscriptsdk-0.8.10
	dunce-1.0.2
	either-1.6.1
	encoding-0.2.33
	encoding-index-japanese-1.20141219.5
	encoding-index-korean-1.20141219.5
	encoding-index-simpchinese-1.20141219.5
	encoding-index-singlebyte-1.20141219.5
	encoding-index-tradchinese-1.20141219.5
	encoding_index_tests-0.1.4
	envmnt-0.9.1
	fastrand-1.7.0
	fern-0.6.0
	flate2-1.0.22
	fnv-1.0.7
	foreign-types-0.3.2
	foreign-types-shared-0.1.1
	form_urlencoded-1.0.1
	fs_extra-1.2.0
	fsio-0.3.0
	ftp-3.0.1
	generic-array-0.14.5
	getrandom-0.2.6
	git_info-0.1.2
	glob-0.3.0
	globset-0.4.8
	hashbrown-0.11.2
	heck-0.4.0
	hermit-abi-0.1.19
	home-0.5.3
	http-0.2.6
	idna-0.2.3
	ignore-0.4.18
	indexmap-1.8.1
	instant-0.1.12
	itoa-1.0.1
	java-properties-1.4.1
	js-sys-0.3.57
	kernel32-sys-0.2.2
	lazy_static-0.1.16
	lazy_static-1.4.0
	libc-0.2.122
	log-0.4.16
	matches-0.1.9
	memchr-0.1.11
	memchr-2.4.1
	meval-0.2.0
	miniz_oxide-0.4.4
	native-tls-0.2.10
	nom-1.2.4
	num-0.1.42
	num-integer-0.1.44
	num-iter-0.1.42
	num-traits-0.2.14
	num_cpus-1.13.1
	once_cell-1.10.0
	openssl-0.10.38
	openssl-probe-0.1.5
	openssl-sys-0.9.72
	os_str_bytes-6.0.0
	percent-encoding-2.1.0
	pkg-config-0.3.25
	ppv-lite86-0.2.16
	proc-macro2-1.0.37
	quote-1.0.17
	rand-0.8.5
	rand_chacha-0.3.1
	rand_core-0.6.3
	redox_syscall-0.2.13
	redox_users-0.4.3
	regex-0.1.80
	regex-1.5.5
	regex-syntax-0.3.9
	regex-syntax-0.6.25
	remove_dir_all-0.5.3
	run_script-0.9.0
	rust_info-0.3.2
	ryu-1.0.9
	same-file-1.0.6
	schannel-0.1.19
	security-framework-2.6.1
	security-framework-sys-2.6.1
	semver-1.0.7
	serde-1.0.136
	serde_derive-1.0.136
	serde_ignored-0.1.2
	serde_json-1.0.79
	sha2-0.10.2
	shell2batch-0.4.4
	strsim-0.10.0
	syn-1.0.91
	tempfile-3.3.0
	termcolor-1.1.3
	textwrap-0.15.0
	thiserror-1.0.30
	thiserror-impl-1.0.30
	thread-id-2.0.0
	thread_local-0.2.7
	thread_local-1.1.4
	time-0.1.43
	tinyvec-1.5.1
	tinyvec_macros-0.1.0
	toml-0.5.8
	typenum-1.15.0
	uname-0.1.1
	unicode-bidi-0.3.7
	unicode-normalization-0.1.19
	unicode-xid-0.2.2
	url-2.2.2
	users-0.11.0
	utf8-ranges-0.1.3
	vcpkg-0.2.15
	version_check-0.9.4
	walkdir-2.3.2
	wasi-0.10.2+wasi-snapshot-preview1
	wasm-bindgen-0.2.80
	wasm-bindgen-backend-0.2.80
	wasm-bindgen-macro-0.2.80
	wasm-bindgen-macro-support-0.2.80
	wasm-bindgen-shared-0.2.80
	web-sys-0.3.57
	which-4.2.5
	whoami-1.2.1
	wildmatch-2.1.0
	winapi-0.2.8
	winapi-0.3.9
	winapi-build-0.1.1
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
"

inherit cargo

DESCRIPTION="Rust task runner and build tool"
HOMEPAGE="https://github.com/sagiegurari/cargo-make"
SRC_URI="
	https://github.com/sagiegurari/cargo-make/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris)
"
LICENSE="
	|| ( 0BSD Apache-2.0 MIT )
	|| ( Apache-2.0 Boost-1.0 )
	|| ( Apache-2.0 Boost-1.0 MIT )
	|| ( Apache-2.0 MIT )
	|| ( Apache-2.0 MIT ZLIB )
	|| ( Apache-2.0-with-LLVM-exceptions Apache-2.0 MIT )
	|| ( MIT Unlicense )
	Apache-2.0
	BSD
	CC0-1.0
	MIT
	MPL-2.0
"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ssl"

DEPEND="ssl? ( dev-libs/openssl )"
RDEPEND="${DEPEND}"

QA_FLAGS_IGNORED="usr/bin/.*"

src_configure() {
	use ssl || features="--no-default-features"
	cargo_src_configure "${features}"
}

src_install() {
	cargo_src_install
	dodoc README.md
}
