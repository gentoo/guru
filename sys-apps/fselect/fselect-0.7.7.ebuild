# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
	adler-1.0.2
	ahash-0.4.7
	aho-corasick-0.7.18
	ansi_term-0.12.1
	atty-0.2.14
	autocfg-1.0.1
	base64-0.13.0
	bitflags-1.2.1
	bitreader-0.3.4
	bitstream-io-1.2.0
	block-buffer-0.9.0
	block-padding-0.2.1
	bstr-0.2.17
	bytecount-0.6.2
	byteorder-1.4.3
	bzip2-0.4.3
	bzip2-sys-0.1.11+1.0.8
	cc-1.0.70
	cfg-if-0.1.10
	cfg-if-1.0.0
	chrono-0.4.19
	chrono-english-0.1.6
	clipboard-win-4.2.1
	cloudabi-0.0.3
	cpufeatures-0.2.1
	crc32fast-1.2.1
	csv-1.1.6
	csv-core-0.1.10
	digest-0.9.0
	directories-4.0.1
	dirs-next-2.0.0
	dirs-sys-0.3.6
	dirs-sys-next-0.1.2
	either-1.6.1
	endian-type-0.1.2
	env_logger-0.8.4
	error-code-2.3.0
	fallible_collections-0.3.1
	fd-lock-3.0.0
	fixedbitset-0.2.0
	flate2-1.0.22
	fnv-1.0.7
	generic-array-0.14.4
	getrandom-0.1.16
	getrandom-0.2.3
	hashbrown-0.9.1
	hashbrown-0.11.2
	hermit-abi-0.1.19
	humansize-1.1.1
	humantime-2.1.0
	imagesize-0.9.0
	indexmap-1.7.0
	itertools-0.8.2
	itoa-0.4.8
	kamadak-exif-0.5.4
	keccak-0.1.0
	lazy_static-1.4.0
	libc-0.2.103
	lock_api-0.3.4
	log-0.4.14
	lscolors-0.8.0
	matroska-0.7.0
	memchr-1.0.2
	memchr-2.4.1
	memoffset-0.6.4
	miniz_oxide-0.4.4
	mp3-metadata-0.3.3
	mp4parse-0.11.5
	mutate_once-0.1.1
	nibble_vec-0.1.0
	nix-0.22.2
	nom-3.2.1
	num-integer-0.1.44
	num-traits-0.2.14
	opaque-debug-0.3.0
	parking_lot-0.10.2
	parking_lot_core-0.7.2
	petgraph-0.5.1
	phf-0.8.0
	phf_generator-0.8.0
	phf_macros-0.8.0
	phf_shared-0.8.0
	pkg-config-0.3.20
	ppv-lite86-0.2.10
	proc-macro-hack-0.5.19
	proc-macro2-1.0.29
	quote-1.0.10
	radix_trie-0.2.1
	rand-0.7.3
	rand-0.8.4
	rand_chacha-0.2.2
	rand_chacha-0.3.1
	rand_core-0.5.1
	rand_core-0.6.3
	rand_hc-0.2.0
	rand_hc-0.3.1
	rand_pcg-0.2.1
	redox_syscall-0.1.57
	redox_syscall-0.2.10
	redox_users-0.4.0
	regex-1.5.4
	regex-automata-0.1.10
	regex-syntax-0.6.25
	rustyline-9.0.0
	ryu-1.0.5
	scanlex-0.1.4
	scopeguard-1.1.0
	serde-1.0.130
	serde_derive-1.0.130
	serde_json-1.0.68
	sha-1-0.9.8
	sha2-0.9.8
	sha3-0.9.1
	siphasher-0.3.7
	smallvec-1.7.0
	static_assertions-1.1.0
	str-buf-1.0.5
	svg-0.10.0
	syn-1.0.80
	termcolor-1.1.2
	thiserror-1.0.29
	thiserror-impl-1.0.29
	time-0.1.43
	toml-0.5.8
	tree_magic-0.2.3
	typenum-1.14.0
	unicode-segmentation-1.8.0
	unicode-width-0.1.9
	unicode-xid-0.2.2
	users-0.11.0
	utf8parse-0.2.0
	version_check-0.9.3
	wana_kana-2.0.1
	wasi-0.9.0+wasi-snapshot-preview1
	wasi-0.10.2+wasi-snapshot-preview1
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	xattr-0.2.2
	zip-0.5.13
"

inherit cargo

DESCRIPTION="Find files with SQL-like queries"
HOMEPAGE="https://github.com/jhspetersson/fselect"
SRC_URI="https://github.com/jhspetersson/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
$(cargo_crate_uris ${CRATES})"

LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD BSD-2 Boost-1.0 CC0-1.0 MIT MPL-2.0 Unlicense ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+users"

QA_FLAGS_IGNORED="/usr/bin/fselect"
DOCS=( README.md docs/usage.md )

src_configure() {
	local myfeatures=(
		$(usev users)
	)
	cargo_src_configure --no-default-features
}

src_compile() {
	cargo_src_compile --workspace
}

src_install() {
	cargo_src_install
	doman docs/*.1
	einstalldocs
}
