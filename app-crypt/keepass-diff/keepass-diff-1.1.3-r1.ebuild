# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	adler@0.2.3
	aes@0.7.4
	arrayref@0.3.6
	arrayvec@0.5.2
	atty@0.2.14
	autocfg@1.0.1
	base64@0.13.0
	bitflags@1.2.1
	blake2b_simd@0.5.11
	block-buffer@0.9.0
	block-modes@0.8.1
	block-padding@0.2.1
	byteorder@1.4.2
	cfg-if@1.0.0
	chacha20@0.7.2
	chrono@0.4.19
	cipher@0.3.0
	clap@3.0.10
	clap_derive@3.0.6
	constant_time_eq@0.1.5
	cpufeatures@0.1.5
	crc32fast@1.2.1
	crossbeam-utils@0.8.1
	crypto-mac@0.11.1
	digest@0.9.0
	flate2@1.0.20
	generic-array@0.14.4
	hashbrown@0.11.2
	heck@0.4.0
	hermit-abi@0.1.18
	hex-literal@0.3.3
	hmac@0.11.0
	indexmap@1.8.0
	keepass@0.4.9
	lazy_static@1.4.0
	libc@0.2.98
	memchr@2.4.1
	miniz_oxide@0.4.3
	num-integer@0.1.44
	num-traits@0.2.14
	opaque-debug@0.3.0
	os_str_bytes@6.0.0
	proc-macro-error@1.0.4
	proc-macro-error-attr@1.0.4
	proc-macro2@1.0.36
	quote@1.0.14
	rpassword@5.0.1
	rust-argon2@0.8.3
	salsa20@0.8.1
	secstr@0.4.0
	sha2@0.9.5
	strsim@0.10.0
	subtle@2.4.1
	syn@1.0.85
	termcolor@1.1.2
	terminal_size@0.1.17
	textwrap@0.14.2
	time@0.1.44
	twofish@0.6.0
	typenum@1.12.0
	unicode-xid@0.2.2
	version_check@0.9.3
	wasi@0.10.0+wasi-snapshot-preview1
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.5
	winapi-x86_64-pc-windows-gnu@0.4.0
	xml-rs@0.8.3
"

inherit cargo

DESCRIPTION="A CLI tool to diff Keepass (.kdbx) files"
HOMEPAGE="https://github.com/Narigo/keepass-diff"
SRC_URI="
	https://github.com/Narigo/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="Apache-2.0 BSD BSD-2 CC0-1.0 MIT Unlicense"
SLOT="0"
KEYWORDS="~amd64"

QA_FLAGS_IGNORED="usr/bin/${PN}" # silence warnings
