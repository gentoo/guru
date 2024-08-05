# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	addr2line@0.21.0
	adler@1.0.2
	ahash@0.8.11
	aho-corasick@1.1.3
	anstream@0.6.14
	anstyle@1.0.7
	anstyle-parse@0.2.4
	anstyle-query@1.0.3
	anstyle-wincon@3.0.3
	assert_cmd@2.0.14
	autocfg@1.3.0
	backtrace@0.3.71
	bstr@1.9.1
	bytes@1.6.0
	cc@1.0.96
	cfg-if@1.0.0
	clap@4.5.4
	clap_builder@4.5.2
	clap_complete@4.5.2
	clap_derive@4.5.4
	clap_lex@0.7.0
	clap_mangen@0.2.20
	colorchoice@1.0.1
	derive_more@0.99.17
	difflib@0.4.0
	doc-comment@0.3.3
	equivalent@1.0.1
	gimli@0.28.1
	hashbrown@0.14.5
	heck@0.5.0
	hyprland@0.4.0-alpha.1
	hyprland-macros@0.4.0-alpha.1
	indexmap@2.2.6
	is_terminal_polyfill@1.70.0
	itoa@1.0.11
	libc@0.2.154
	memchr@2.7.2
	miniz_oxide@0.7.2
	mio@0.8.11
	num-traits@0.2.19
	object@0.32.2
	once_cell@1.19.0
	paste@1.0.14
	pin-project-lite@0.2.14
	predicates@3.1.0
	predicates-core@1.0.6
	predicates-tree@1.0.9
	proc-macro2@1.0.81
	quote@1.0.36
	regex@1.10.4
	regex-automata@0.4.6
	regex-syntax@0.8.3
	roff@0.2.1
	rustc-demangle@0.1.23
	rustympkglib@0.1.1
	ryu@1.0.17
	serde@1.0.200
	serde_derive@1.0.200
	serde_json@1.0.116
	serde_repr@0.1.19
	serde_spanned@0.6.5
	socket2@0.5.7
	strsim@0.11.1
	syn@1.0.109
	syn@2.0.60
	termtree@0.4.1
	tokio@1.37.0
	toml@0.8.12
	toml_datetime@0.6.5
	toml_edit@0.22.12
	tree-sitter@0.19.5
	tree-sitter-bash@0.19.0
	unicode-ident@1.0.12
	utf8parse@0.2.1
	version_check@0.9.4
	wait-timeout@0.2.0
	wasi@0.11.0+wasi-snapshot-preview1
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-targets@0.48.5
	windows-targets@0.52.5
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.5
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.5
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.5
	windows_i686_gnullvm@0.52.5
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.5
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.5
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.5
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.5
	winnow@0.6.7
	zerocopy@0.7.33
	zerocopy-derive@0.7.33
"

inherit cargo

DESCRIPTION="GNOME-like workspace switching in Hyprland."
HOMEPAGE="https://github.com/donovanglover/hyprnome"
SRC_URI="
	https://github.com/donovanglover/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 Boost-1.0 GPL-3+ MIT ZLIB"
SLOT="0"
KEYWORDS="~amd64"

QA_FLAGS_IGNORED="usr/bin/${PN}"
