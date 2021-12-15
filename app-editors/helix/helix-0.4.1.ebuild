# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	aho-corasick-0.7.18
	anyhow-1.0.42
	arc-swap-1.3.0
	autocfg-1.0.1
	bitflags-1.3.1
	bstr-0.2.16
	bytes-1.0.1
	cassowary-0.3.0
	cc-1.0.69
	cfg-if-1.0.0
	chardetng-0.1.14
	chrono-0.4.19
	clipboard-win-4.2.1
	crossbeam-utils-0.8.5
	crossterm-0.20.0
	crossterm_winapi-0.8.0
	dirs-next-2.0.0
	dirs-sys-next-0.1.2
	either-1.6.1
	encoding_rs-0.8.28
	error-code-2.3.0
	etcetera-0.3.2
	fern-0.6.0
	fnv-1.0.7
	form_urlencoded-1.0.1
	futf-0.1.4
	futures-core-0.3.16
	futures-executor-0.3.16
	futures-task-0.3.16
	futures-util-0.3.16
	fuzzy-matcher-0.3.7
	getrandom-0.2.3
	globset-0.4.8
	hermit-abi-0.1.19
	idna-0.2.3
	ignore-0.4.18
	instant-0.1.10
	itoa-0.4.7
	jsonrpc-core-18.0.0
	lazy_static-1.4.0
	libc-0.2.99
	libloading-0.7.0
	lock_api-0.4.4
	log-0.4.14
	lsp-types-0.89.2
	mac-0.1.1
	matches-0.1.9
	memchr-2.4.0
	mio-0.7.13
	miow-0.3.7
	new_debug_unreachable-1.0.4
	ntapi-0.3.6
	num-integer-0.1.44
	num-traits-0.2.14
	num_cpus-1.13.0
	once_cell-1.8.0
	parking_lot-0.11.1
	parking_lot_core-0.8.3
	percent-encoding-2.1.0
	pin-project-lite-0.2.7
	pin-utils-0.1.0
	proc-macro2-1.0.28
	pulldown-cmark-0.8.0
	quickcheck-1.0.3
	quote-1.0.9
	rand-0.8.4
	rand_core-0.6.3
	redox_syscall-0.2.10
	redox_users-0.4.0
	regex-1.5.4
	regex-syntax-0.6.25
	ropey-1.3.1
	ryu-1.0.5
	same-file-1.0.6
	scopeguard-1.1.0
	serde-1.0.127
	serde_derive-1.0.127
	serde_json-1.0.66
	serde_repr-0.1.7
	signal-hook-0.3.9
	signal-hook-mio-0.2.1
	signal-hook-registry-1.4.0
	signal-hook-tokio-0.3.0
	similar-1.3.0
	slab-0.4.4
	slotmap-1.0.5
	smallvec-1.6.1
	str-buf-1.0.5
	syn-1.0.74
	tendril-0.4.2
	thiserror-1.0.26
	thiserror-impl-1.0.26
	thread_local-1.1.3
	threadpool-1.8.1
	tinyvec-1.3.1
	tinyvec_macros-0.1.0
	tokio-1.10.0
	tokio-macros-1.3.0
	tokio-stream-0.1.7
	toml-0.5.8
	tree-sitter-0.19.5
	unicase-2.6.0
	unicode-bidi-0.3.6
	unicode-general-category-0.4.0
	unicode-normalization-0.1.19
	unicode-segmentation-1.8.0
	unicode-width-0.1.8
	unicode-xid-0.2.2
	url-2.2.2
	utf-8-0.7.6
	version_check-0.9.3
	walkdir-2.3.2
	wasi-0.10.2+wasi-snapshot-preview1
	which-4.2.2
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
"

inherit cargo git-r3

DESCRIPTION="A post-modern text editor."
HOMEPAGE="https://helix-editor.com"
EGIT_REPO_URI="https://github.com/helix-editor/${PN}.git"
EGIT_BRANCH="master"
EGIT_COMMIT="1caedc18ca47d07b30a5997c092f2683cce3042e"
SRC_URI="$(cargo_crate_uris)"
LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD Boost-1.0 ISC MIT MPL-2.0 Unlicense ZLIB"
SLOT="0"

BDEPEND="virtual/rust"

PATCHES=(
	"${FILESDIR}/${PN}-0.4.1.patch"
)

QA_FLAGS_IGNORED="
	usr/share/helix/runtime/grammars/agda.so
	usr/share/helix/runtime/grammars/bash.so
	usr/share/helix/runtime/grammars/c-sharp.so
	usr/share/helix/runtime/grammars/c.so
	usr/share/helix/runtime/grammars/cpp.so
	usr/share/helix/runtime/grammars/css.so
	usr/share/helix/runtime/grammars/elixir.so
	usr/share/helix/runtime/grammars/go.so
	usr/share/helix/runtime/grammars/html.so
	usr/share/helix/runtime/grammars/java.so
	usr/share/helix/runtime/grammars/javascript.so
	usr/share/helix/runtime/grammars/json.so
	usr/share/helix/runtime/grammars/julia.so
	usr/share/helix/runtime/grammars/latex.so
	usr/share/helix/runtime/grammars/nix.so
	usr/share/helix/runtime/grammars/php.so
	usr/share/helix/runtime/grammars/python.so
	usr/share/helix/runtime/grammars/ruby.so
	usr/share/helix/runtime/grammars/rust.so
	usr/share/helix/runtime/grammars/scala.so
	usr/share/helix/runtime/grammars/swift.so
	usr/share/helix/runtime/grammars/toml.so
	usr/share/helix/runtime/grammars/tsx.so
	usr/share/helix/runtime/grammars/typescript.so
	usr/bin/hx
"

src_prepare() {
	einfo "Helix branch: ${EGIT_BRANCH}"
	einfo "Commit: ${EGIT_COMMIT}"

	default

	cargo_src_unpack
}

src_configure() {
	cargo_src_configure
}

src_compile() {
	cargo_src_compile
}

src_install() {
	insinto /usr/share/helix
	doins -r runtime

	cargo_src_install --path helix-term
}
