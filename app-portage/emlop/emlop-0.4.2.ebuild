# Copyright 2017-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
	aho-corasick-0.7.18
	ansi_term-0.11.0
	ansi_term-0.12.1
	anyhow-1.0.43
	assert_cmd-1.0.8
	atty-0.2.14
	autocfg-1.0.1
	bitflags-1.3.2
	bstr-0.2.16
	cfg-if-1.0.0
	chrono-0.4.19
	chrono-english-0.1.6
	clap-2.33.3
	crossbeam-channel-0.5.1
	crossbeam-utils-0.8.5
	difflib-0.4.0
	doc-comment-0.3.3
	either-1.6.1
	emlop-0.4.2
	errno-0.2.7
	errno-dragonfly-0.1.1
	escargot-0.5.2
	gcc-0.3.55
	hermit-abi-0.1.19
	itertools-0.10.1
	itoa-0.4.7
	kernel32-sys-0.2.2
	lazy_static-1.4.0
	libc-0.2.99
	log-0.4.14
	memchr-2.4.1
	num-integer-0.1.44
	num-traits-0.2.14
	once_cell-1.8.0
	predicates-2.0.2
	predicates-core-1.0.2
	predicates-tree-1.0.3
	proc-macro2-1.0.28
	quote-1.0.9
	regex-1.5.4
	regex-automata-0.1.10
	regex-syntax-0.6.25
	ryu-1.0.5
	scanlex-0.1.4
	serde-1.0.127
	serde_derive-1.0.127
	serde_json-1.0.66
	stderrlog-0.5.1
	strsim-0.8.0
	syn-1.0.74
	sysconf-0.3.4
	tabwriter-1.2.1
	termcolor-1.1.2
	textwrap-0.11.0
	thread_local-1.0.1
	time-0.1.44
	treeline-0.1.0
	unicode-width-0.1.8
	unicode-xid-0.2.2
	vec_map-0.8.2
	wait-timeout-0.2.0
	wasi-0.10.0+wasi-snapshot-preview1
	winapi-0.2.8
	winapi-0.3.9
	winapi-build-0.1.1
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
"

inherit cargo bash-completion-r1

DESCRIPTION="A fast, accurate, ergonomic emerge.log parser"
HOMEPAGE="https://github.com/vincentdephily/emlop"
SRC_URI="$(cargo_crate_uris ${CRATES})"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="bash-completion zsh-completion fish-completion"
RESTRICT="mirror"

QA_FLAGS_IGNORED="usr/bin/emlop"

DOCS=( "README.md" "CHANGELOG.md" )

src_install() {
	cargo_src_install
	einstalldocs
	if use bash-completion; then
		./target/release/emlop complete bash > emlop
		dobashcomp emlop
	fi
	if use zsh-completion; then
		./target/release/emlop complete zsh > _emlop
		insinto /usr/share/zsh/site-functions
		doins _emlop
	fi
	if use fish-completion; then
		./target/release/emlop complete fish > emlop.fish
		insinto /usr/share/fish/vendor_completions.d
		doins emlop.fish
	fi
}
