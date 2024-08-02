# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	aho-corasick@1.1.2
	anstream@0.6.4
	anstyle@1.0.4
	anstyle-parse@0.2.2
	anstyle-query@1.0.0
	anstyle-wincon@3.0.1
	anyhow@1.0.75
	assert_cmd@0.10.2
	autocfg@1.1.0
	bitflags@1.3.2
	bitflags@2.4.1
	cfg-if@1.0.0
	clap@4.4.10
	clap_builder@4.4.9
	clap_derive@4.4.7
	clap_lex@0.6.0
	colorchoice@1.0.0
	difference@2.0.0
	directories@1.0.2
	errno@0.3.8
	escargot@0.3.1
	fastrand@2.0.1
	float-cmp@0.8.0
	heck@0.4.1
	itoa@1.0.9
	libc@0.2.150
	linux-raw-sys@0.4.12
	memchr@2.6.4
	normalize-line-endings@0.3.0
	num-traits@0.2.17
	predicates@1.0.8
	predicates-core@1.0.6
	predicates-tree@1.0.9
	proc-macro2@1.0.70
	quote@1.0.33
	redox_syscall@0.4.1
	regex@1.10.2
	regex-automata@0.4.3
	regex-syntax@0.8.2
	rustix@0.38.26
	ryu@1.0.15
	serde@1.0.193
	serde_derive@1.0.193
	serde_json@1.0.108
	strsim@0.10.0
	syn@2.0.39
	tempfile@3.8.1
	termtree@0.4.1
	unicode-ident@1.0.12
	utf8parse@0.2.1
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-targets@0.48.5
	windows-targets@0.52.0
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.0
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.0
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.0
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.0
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.0
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.0
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.0
"

inherit cargo

DESCRIPTION="A command line frecency tracking tool"
HOMEPAGE="https://github.com/camdencheek/fre"
SRC_URI="
	https://github.com/camdencheek/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}"

LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions Boost-1.0 MIT Unicode-DFS-2016 Unlicense"
SLOT="0"
KEYWORDS="~amd64"

QA_FLAGS_IGNORED="usr/bin/${PN}"
