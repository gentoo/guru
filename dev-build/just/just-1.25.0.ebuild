# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	aho-corasick@1.1.2
	ansi_term@0.12.1
	anstream@0.6.13
	anstyle@1.0.6
	anstyle-parse@0.2.3
	anstyle-query@1.0.2
	anstyle-wincon@3.0.2
	arrayref@0.3.7
	arrayvec@0.7.4
	atty@0.2.14
	bitflags@1.3.2
	bitflags@2.4.2
	blake3@1.5.0
	block-buffer@0.10.4
	bstr@0.2.17
	camino@1.1.6
	cc@1.0.90
	cfg-if@1.0.0
	clap@2.34.0
	colorchoice@1.0.0
	constant_time_eq@0.3.0
	cpufeatures@0.2.12
	cradle@0.2.2
	crossbeam-deque@0.8.5
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.19
	crypto-common@0.1.6
	ctrlc@3.4.2
	derivative@2.2.0
	diff@0.1.13
	digest@0.10.7
	dirs@5.0.1
	dirs-sys@0.4.1
	dotenvy@0.15.7
	edit-distance@2.1.0
	either@1.10.0
	env_filter@0.1.0
	env_logger@0.11.3
	errno@0.3.8
	executable-path@1.0.0
	fastrand@2.0.1
	generic-array@0.14.7
	getopts@0.2.21
	getrandom@0.2.12
	heck@0.3.3
	heck@0.4.1
	hermit-abi@0.1.19
	hermit-abi@0.3.9
	home@0.5.9
	humantime@2.1.0
	itoa@1.0.10
	lazy_static@1.4.0
	lexiclean@0.0.1
	libc@0.2.153
	libredox@0.0.1
	linked-hash-map@0.5.6
	linux-raw-sys@0.4.13
	log@0.4.21
	memchr@2.7.1
	memmap2@0.7.1
	nix@0.27.1
	num_cpus@1.16.0
	once_cell@1.19.0
	option-ext@0.2.0
	pretty_assertions@1.4.0
	proc-macro-error@1.0.4
	proc-macro-error-attr@1.0.4
	proc-macro2@1.0.78
	pulldown-cmark@0.9.6
	pulldown-cmark-to-cmark@10.0.4
	quote@1.0.35
	rayon@1.9.0
	rayon-core@1.12.1
	redox_syscall@0.4.1
	redox_users@0.4.4
	regex@1.10.3
	regex-automata@0.1.10
	regex-automata@0.4.6
	regex-syntax@0.8.2
	rustix@0.38.31
	rustversion@1.0.14
	ryu@1.0.17
	semver@1.0.22
	serde@1.0.197
	serde_derive@1.0.197
	serde_json@1.0.114
	sha2@0.10.8
	similar@2.4.0
	snafu@0.8.1
	snafu-derive@0.8.1
	strsim@0.8.0
	structopt@0.3.26
	structopt-derive@0.4.18
	strum@0.26.1
	strum_macros@0.26.1
	syn@1.0.109
	syn@2.0.52
	target@2.0.0
	tempfile@3.10.1
	temptree@0.2.0
	term_size@0.3.2
	textwrap@0.11.0
	thiserror@1.0.57
	thiserror-impl@1.0.57
	typed-arena@2.0.2
	typenum@1.17.0
	unicase@2.7.0
	unicode-ident@1.0.12
	unicode-segmentation@1.11.0
	unicode-width@0.1.11
	utf8parse@0.2.1
	uuid@1.7.0
	vec_map@0.8.2
	version_check@0.9.4
	wasi@0.11.0+wasi-snapshot-preview1
	which@6.0.0
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-targets@0.48.5
	windows-targets@0.52.4
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.4
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.4
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.4
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.4
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.4
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.4
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.4
	yaml-rust@0.4.5
	yansi@0.5.1
	${P}
"

inherit cargo shell-completion toolchain-funcs

DESCRIPTION="Just a command runner (with syntax inspired by 'make')"
HOMEPAGE="
	https://just.systems/
	https://crates.io/crates/just
	https://github.com/casey/just
"
SRC_URI="$(cargo_crate_uris ${CRATES})"

LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD Boost-1.0 CC0-1.0 MIT Unicode-DFS-2016 Unlicense"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
RESTRICT="mirror"

QA_FLAGS_IGNORED="usr/bin/${PN}"

src_test() {
	# $USER must be set or tests fail Bug #890889
	export USER=portage
	default
}

src_prepare() {
	default
	tc-export CC
}

src_install() {
	local DOCS=( README.md )

	cargo_src_install

	doman man/*

	einstalldocs

	# bash-completion
	newbashcomp "completions/${PN}.bash" "${PN}"

	# zsh-completion
	newzshcomp "completions/${PN}.zsh" "_${PN}"

	# fish-completion
	dofishcomp "completions/${PN}.fish"
}
