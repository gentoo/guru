# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	aho-corasick@1.1.2
	ansi_term@0.12.1
	atty@0.2.14
	bitflags@1.3.2
	bitflags@2.4.1
	block-buffer@0.10.4
	bstr@0.2.17
	camino@1.1.6
	cfg-if@1.0.0
	clap@2.34.0
	cpufeatures@0.2.11
	cradle@0.2.2
	crypto-common@0.1.6
	ctrlc@3.4.2
	derivative@2.2.0
	diff@0.1.13
	digest@0.10.7
	doc-comment@0.3.3
	dotenvy@0.15.7
	edit-distance@2.1.0
	either@1.9.0
	env_logger@0.10.1
	errno@0.3.8
	executable-path@1.0.0
	fastrand@2.0.1
	generic-array@0.14.7
	getopts@0.2.21
	getrandom@0.2.11
	heck@0.3.3
	heck@0.4.1
	hermit-abi@0.1.19
	hermit-abi@0.3.3
	home@0.5.9
	humantime@2.1.0
	is-terminal@0.4.9
	itoa@1.0.10
	lazy_static@1.4.0
	lexiclean@0.0.1
	libc@0.2.151
	linked-hash-map@0.5.6
	linux-raw-sys@0.4.12
	log@0.4.20
	memchr@2.6.4
	nix@0.27.1
	num_cpus@1.16.0
	once_cell@1.19.0
	pretty_assertions@1.4.0
	proc-macro-error@1.0.4
	proc-macro-error-attr@1.0.4
	proc-macro2@1.0.71
	pulldown-cmark@0.9.3
	pulldown-cmark-to-cmark@10.0.4
	quote@1.0.33
	redox_syscall@0.4.1
	regex@1.10.2
	regex-automata@0.1.10
	regex-automata@0.4.3
	regex-syntax@0.8.2
	rustix@0.38.28
	rustversion@1.0.14
	ryu@1.0.16
	semver@1.0.20
	serde@1.0.193
	serde_derive@1.0.193
	serde_json@1.0.108
	sha2@0.10.8
	similar@2.3.0
	snafu@0.7.5
	snafu-derive@0.7.5
	strsim@0.8.0
	structopt@0.3.26
	structopt-derive@0.4.18
	strum@0.25.0
	strum_macros@0.25.3
	syn@1.0.109
	syn@2.0.43
	target@2.0.0
	tempfile@3.9.0
	temptree@0.2.0
	term_size@0.3.2
	termcolor@1.4.0
	textwrap@0.11.0
	typed-arena@2.0.2
	typenum@1.17.0
	unicase@2.7.0
	unicode-ident@1.0.12
	unicode-segmentation@1.10.1
	unicode-width@0.1.11
	uuid@1.6.1
	vec_map@0.8.2
	version_check@0.9.4
	wasi@0.11.0+wasi-snapshot-preview1
	which@5.0.0
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.6
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
