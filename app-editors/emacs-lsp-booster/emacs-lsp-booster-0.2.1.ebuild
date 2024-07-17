# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	aho-corasick@1.1.2
	anstream@0.6.5
	anstyle-parse@0.2.3
	anstyle-query@1.0.2
	anstyle-wincon@3.0.2
	anstyle@1.0.4
	anyhow@1.0.78
	bitflags@1.3.2
	bitflags@2.4.1
	cfg-if@1.0.0
	clap-verbosity-flag@2.1.1
	clap@4.4.13
	clap_builder@4.4.12
	clap_derive@4.4.7
	clap_lex@0.6.0
	colorchoice@1.0.0
	ctor@0.1.26
	darling@0.10.2
	darling_core@0.10.2
	darling_macro@0.10.2
	either@1.11.0
	emacs-macros@0.17.0
	emacs@0.18.0
	emacs_module@0.18.0
	env_logger@0.10.1
	errno@0.3.8
	fastrand@2.0.1
	fnv@1.0.7
	heck@0.4.1
	hermit-abi@0.3.3
	home@0.5.9
	humantime@2.1.0
	ident_case@1.0.1
	is-terminal@0.4.10
	itoa@1.0.10
	lazy_static@1.4.0
	libc@0.2.153
	linux-raw-sys@0.4.12
	log@0.4.20
	memchr@2.7.1
	once_cell@1.19.0
	proc-macro2@1.0.72
	quote@1.0.33
	redox_syscall@0.4.1
	regex-automata@0.4.3
	regex-syntax@0.8.2
	regex@1.10.2
	rustc_version@0.2.3
	rustix@0.38.32
	ryu@1.0.16
	semver-parser@0.7.0
	semver@0.9.0
	serde@1.0.193
	serde_derive@1.0.193
	serde_json@1.0.108
	smallvec@1.11.2
	strsim@0.10.0
	strsim@0.9.3
	syn@1.0.109
	syn@2.0.43
	tempfile@3.9.0
	termcolor@1.4.0
	thiserror-impl@1.0.53
	thiserror@1.0.53
	unicode-ident@1.0.12
	utf8parse@0.2.1
	which@6.0.1
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.6
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-sys@0.52.0
	windows-targets@0.52.0
	windows_aarch64_gnullvm@0.52.0
	windows_aarch64_msvc@0.52.0
	windows_i686_gnu@0.52.0
	windows_i686_msvc@0.52.0
	windows_x86_64_gnu@0.52.0
	windows_x86_64_gnullvm@0.52.0
	windows_x86_64_msvc@0.52.0
	winsafe@0.0.19
"

inherit cargo

DESCRIPTION="Emacs LSP performance booster"
HOMEPAGE="https://github.com/blahgeek/emacs-lsp-booster"
SRC_URI="
	https://github.com/blahgeek/emacs-lsp-booster/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+="
	BSD MIT Unicode-DFS-2016
	|| ( Apache-2.0 Boost-1.0 )
"
SLOT="0"
KEYWORDS="~amd64"

IUSE="test"
RESTRICT="!test? ( test )"

# Native JSON support always available with >=emacs-30.1
BDEPEND="test? ( >=app-editors/emacs-27.1[json(+)] )"

# rust does not use *FLAGS from make.conf, silence portage warning
QA_FLAGS_IGNORED="usr/bin/${PN}"
