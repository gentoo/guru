# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	aho-corasick-0.7.10
	ansi_term-0.11.0
	anyhow-1.0.32
	assert_cmd-1.0.1
	atty-0.2.14
	autocfg-1.0.0
	bitflags-1.2.1
	cfg-if-0.1.10
	clap-2.33.0
	crossbeam-deque-0.7.3
	crossbeam-epoch-0.8.2
	crossbeam-queue-0.2.1
	crossbeam-utils-0.7.2
	difference-2.0.0
	doc-comment-0.3.3
	either-1.5.3
	getrandom-0.1.14
	heck-0.3.1
	hermit-abi-0.1.11
	lazy_static-1.4.0
	libc-0.2.69
	man-0.3.0
	maybe-uninit-2.0.0
	memchr-2.3.3
	memmap-0.7.0
	memoffset-0.5.4
	num_cpus-1.13.0
	ppv-lite86-0.2.6
	predicates-1.0.4
	predicates-core-1.0.0
	predicates-tree-1.0.0
	proc-macro-error-1.0.2
	proc-macro-error-attr-1.0.2
	proc-macro2-1.0.10
	quote-1.0.3
	rand-0.7.3
	rand_chacha-0.2.2
	rand_core-0.5.1
	rand_hc-0.2.0
	rayon-1.3.1
	rayon-core-1.7.1
	redox_syscall-0.1.56
	regex-1.3.9
	regex-syntax-0.6.18
	remove_dir_all-0.5.2
	roff-0.1.0
	scopeguard-1.1.0
	strsim-0.8.0
	structopt-0.3.15
	structopt-derive-0.4.8
	syn-1.0.17
	syn-mid-0.5.0
	tempfile-3.1.0
	textwrap-0.11.0
	thiserror-1.0.20
	thiserror-impl-1.0.20
	thread_local-1.0.1
	treeline-0.1.0
	unescape-0.1.0
	unicode-segmentation-1.6.0
	unicode-width-0.1.7
	unicode-xid-0.2.0
	vec_map-0.8.1
	version_check-0.9.1
	wait-timeout-0.2.0
	wasi-0.9.0+wasi-snapshot-preview1
	winapi-0.3.8
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-x86_64-pc-windows-gnu-0.4.0
	"

inherit cargo

DESCRIPTION="Intuitive find & replace CLI (sed alternative)"
HOMEPAGE="https://github.com/chmln/sd"
SRC_URI="
	https://github.com/chmln/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris)
	"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_install() {
	cargo_src_install
	dodoc CHANGELOG.md README.md
}
