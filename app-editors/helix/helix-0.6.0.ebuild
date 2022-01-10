# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

CRATES="
	aho-corasick-0.7.18
	anyhow-1.0.52
	arc-swap-1.5.0
	autocfg-1.0.1
	bitflags-1.3.2
	bstr-0.2.17
	bytecount-0.6.2
	bytes-1.1.0
	cassowary-0.3.0
	cc-1.0.72
	cfg-if-1.0.0
	chardetng-0.1.17
	chrono-0.4.19
	clipboard-win-4.2.2
	content_inspector-0.2.4
	crossbeam-utils-0.8.5
	crossterm-0.22.1
	crossterm_winapi-0.9.0
	dirs-next-2.0.0
	dirs-sys-next-0.1.2
	either-1.6.1
	encoding_rs-0.8.30
	encoding_rs_io-0.1.7
	error-code-2.3.0
	etcetera-0.3.2
	fern-0.6.0
	fnv-1.0.7
	form_urlencoded-1.0.1
	futf-0.1.4
	futures-core-0.3.19
	futures-executor-0.3.19
	futures-task-0.3.19
	futures-util-0.3.19
	fuzzy-matcher-0.3.7
	getrandom-0.2.3
	globset-0.4.8
	grep-matcher-0.1.5
	grep-regex-0.1.9
	grep-searcher-0.1.8
	hermit-abi-0.1.19
	idna-0.2.3
	ignore-0.4.18
	instant-0.1.12
	itoa-1.0.1
	jsonrpc-core-18.0.0
	lazy_static-1.4.0
	libc-0.2.104
	libloading-0.7.2
	lock_api-0.4.5
	log-0.4.14
	lsp-types-0.91.1
	mac-0.1.1
	matches-0.1.9
	memchr-2.4.1
	memmap2-0.3.1
	mio-0.7.14
	miow-0.3.7
	new_debug_unreachable-1.0.4
	ntapi-0.3.6
	num-integer-0.1.44
	num-traits-0.2.14
	num_cpus-1.13.1
	once_cell-1.9.0
	parking_lot-0.11.2
	parking_lot_core-0.8.5
	percent-encoding-2.1.0
	pin-project-lite-0.2.7
	pin-utils-0.1.0
	proc-macro2-1.0.30
	pulldown-cmark-0.8.0
	quickcheck-1.0.3
	quote-1.0.10
	rand-0.8.4
	rand_core-0.6.3
	redox_syscall-0.2.10
	redox_users-0.4.0
	regex-1.5.4
	regex-automata-0.1.10
	regex-syntax-0.6.25
	ropey-1.3.1
	ryu-1.0.5
	same-file-1.0.6
	scopeguard-1.1.0
	serde-1.0.132
	serde_derive-1.0.132
	serde_json-1.0.73
	serde_repr-0.1.7
	signal-hook-0.3.13
	signal-hook-mio-0.2.1
	signal-hook-registry-1.4.0
	signal-hook-tokio-0.3.0
	similar-2.1.0
	slab-0.4.5
	slotmap-1.0.6
	smallvec-1.7.0
	str-buf-1.0.5
	syn-1.0.80
	tendril-0.4.2
	thiserror-1.0.30
	thiserror-impl-1.0.30
	thread_local-1.1.3
	threadpool-1.8.1
	tinyvec-1.5.0
	tinyvec_macros-0.1.0
	tokio-1.15.0
	tokio-macros-1.7.0
	tokio-stream-0.1.8
	toml-0.5.8
	tree-sitter-0.20.1
	unicase-2.6.0
	unicode-bidi-0.3.7
	unicode-general-category-0.4.0
	unicode-normalization-0.1.19
	unicode-segmentation-1.8.0
	unicode-width-0.1.9
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

inherit cargo

DESCRIPTION="A post-modern text editor."
HOMEPAGE="https://github.com/helix-editor/helix"

SRC_URI="
	https://github.com/helix-editor/helix/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/tree-sitter/tree-sitter-agda/archive/ca69cdf485e9ce2b2ef0991a720aa88d87d30231.tar.gz 
	https://github.com/tree-sitter/tree-sitter-bash/archive/a8eb5cb57c66f74c63ab950de081207cccf52017.tar.gz 
	https://github.com/tree-sitter/tree-sitter-c/archive/f05e279aedde06a25801c3f2b2cc8ac17fac52ae.tar.gz
	https://github.com/tree-sitter/tree-sitter-c-sharp/archive/53a65a908167d6556e1fcdb67f1ee62aac101dda.tar.gz 
	https://github.com/uyha/tree-sitter-cmake/archive/f6616f1e417ee8b62daf251aa1daa5d73781c596.tar.gz
	https://github.com/stsewd/tree-sitter-comment/archive/5dd3c62f1bbe378b220fe16b317b85247898639e.tar.gz
	https://github.com/tree-sitter/tree-sitter-cpp/archive/e8dcc9d2b404c542fd236ea5f7208f90be8a6e89.tar.gz 
	https://github.com/tree-sitter/tree-sitter-css/archive/94e10230939e702b4fa3fa2cb5c3bc7173b95d07.tar.gz
	https://github.com/UserNobody14/tree-sitter-dart/archive/6a25376685d1d47968c2cef06d4db8d84a70025e.tar.gz
	https://github.com/camdencheek/tree-sitter-dockerfile/archive/7af32bc04a66ab196f5b9f92ac471f29372ae2ce.tar.gz
	https://github.com/elixir-lang/tree-sitter-elixir/archive/f5d7bda543da788bd507b05bd722627dde66c9ec.tar.gz
	https://github.com/ram02z/tree-sitter-fish/archive/04e54ab6585dfd4fee6ddfe5849af56f101b6d4f.tar.gz
	https://github.com/the-mikedavis/tree-sitter-git-commit/archive/066e395e1107df17183cf3ae4230f1a1406cc972.tar.gz
	https://github.com/the-mikedavis/tree-sitter-git-diff/archive/c12e6ecb54485f764250556ffd7ccb18f8e2942b.tar.gz
	https://github.com/the-mikedavis/tree-sitter-git-rebase/archive/332dc528f27044bc4427024dbb33e6941fc131f2.tar.gz
	https://github.com/theHamsta/tree-sitter-glsl/archive/88408ffc5e27abcffced7010fc77396ae3636d7e.tar.gz
	https://github.com/tree-sitter/tree-sitter-go/archive/2a83dfdd759a632651f852aa4dc0af2525fae5cd.tar.gz
	https://github.com/tree-sitter/tree-sitter-haskell/archive/237f4eb4417c28f643a29d795ed227246afb66f9.tar.gz
	https://github.com/tree-sitter/tree-sitter-html/archive/d93af487cc75120c89257195e6be46c999c6ba18.tar.gz
	https://github.com/tree-sitter/tree-sitter-java/archive/bd6186c24d5eb13b4623efac9d944dcc095c0dad.tar.gz
	https://github.com/tree-sitter/tree-sitter-javascript/archive/4a95461c4761c624f2263725aca79eeaefd36cad.tar.gz
	https://github.com/tree-sitter/tree-sitter-json/archive/65bceef69c3b0f24c0b19ce67d79f57c96e90fcb.tar.gz
	https://github.com/tree-sitter/tree-sitter-julia/archive/12ea597262125fc22fd2e91aa953ac69b19c26ca.tar.gz
	https://github.com/latex-lsp/tree-sitter-latex/archive/7f720661de5316c0f8fee956526d4002fa1086d8.tar.gz
	https://github.com/cbarrete/tree-sitter-ledger/archive/0cdeb0e51411a3ba5493662952c3039de08939ca.tar.gz
	https://github.com/benwilliamgraham/tree-sitter-llvm/archive/3b213925b9c4f42c1acfe2e10bfbb438d9c6834d.tar.gz
	https://github.com/nvim-treesitter/tree-sitter-lua/archive/6f5d40190ec8a0aa8c8410699353d820f4f7d7a6.tar.gz
	https://github.com/MDeiml/tree-sitter-markdown/archive/ad8c32917a16dfbb387d1da567bf0c3fb6fffde2.tar.gz
	https://github.com/cstrahan/tree-sitter-nix/archive/50f38ceab667f9d482640edfee803d74f4edeba5.tar.gz
	https://github.com/tree-sitter/tree-sitter-ocaml/archive/23d419ba45789c5a47d31448061557716b02750a.tar.gz
	https://github.com/ganezdragon/tree-sitter-perl/archive/0ac2c6da562c7a2c26ed7e8691d4a590f7e8b90a.tar.gz
	https://github.com/tree-sitter/tree-sitter-php/archive/0d63eaf94e8d6c0694551b016c802787e61b3fb2.tar.gz
	https://github.com/yusdacra/tree-sitter-protobuf/archive/19c211a01434d9f03efff99f85e19f967591b175.tar.gz
	https://github.com/tree-sitter/tree-sitter-python/archive/d6210ceab11e8d812d4ab59c07c81458ec6e5184.tar.gz
	https://github.com/tree-sitter/tree-sitter-ruby/archive/dfff673b41df7fadcbb609c6338f38da3cdd018e.tar.gz
	https://github.com/tree-sitter/tree-sitter-rust/archive/a360da0a29a19c281d08295a35ecd0544d2da211.tar.gz
	https://github.com/tree-sitter/tree-sitter-scala/archive/0a3dd53a7fc4b352a538397d054380aaa28be54c.tar.gz
	https://github.com/Himujjal/tree-sitter-svelte/archive/349a5984513b4a4a9e143a6e746120c6ff6cf6ed.tar.gz
	https://github.com/tree-sitter/tree-sitter-swift/archive/a22fa5e19bae50098e2252ea96cba3aba43f4c58.tar.gz
	https://github.com/Flakebi/tree-sitter-tablegen/archive/568dd8a937347175fd58db83d4c4cdaeb6069bd2.tar.gz
	https://github.com/ikatyang/tree-sitter-toml/archive/7cff70bbcbbc62001b465603ca1ea88edd668704.tar.gz
	https://github.com/tree-sitter/tree-sitter-tsq/archive/b665659d3238e6036e22ed0e24935e60efb39415.tar.gz
	https://github.com/tree-sitter/tree-sitter-typescript/archive/3e897ea5925f037cfae2e551f8e6b12eec2a201a.tar.gz
	https://github.com/ikatyang/tree-sitter-vue/archive/91fe2754796cd8fba5f229505a23fa08f3546c06.tar.gz
	https://github.com/szebniok/tree-sitter-wgsl/archive/f00ff52251edbd58f4d39c9c3204383253032c11.tar.gz
	https://github.com/ikatyang/tree-sitter-yaml/archive/0e36bed171768908f331ff7dff9d956bae016efb.tar.gz
	https://github.com/maxxnino/tree-sitter-zig/archive/1f27fd1dfe7f352408f01b4894c7825f3a1d6c47.tar.gz
	$(cargo_crate_uris)
"
# License set may be more restrictive as OR is not respected
# use cargo-license for a more accurate license picture
LICENSE="
	|| ( Apache-2.0 MIT )
	|| ( Apache-2.0 MIT )
	|| ( Apache-2.0 MIT MPL-2.0 )
	|| ( MIT )
	|| ( MIT Unlicense )
	Apache-2.0
	MIT
	Unlicense
	MPL-2.0
"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

DEPEND="
	dev-vcs/git
"

RDEPEND="
	!app-editors/${PN}-bin
"
BDEPEND="app-arch/unzip"

QA_FLAGS_IGNORED="usr/bin/.*"

PATCHES=( "${FILESDIR}/helix-0.6.0-helix-core-lib_rs.patch" )

src_prepare() {
	cp -r -f -n ${PORTAGE_BUILDDIR}/work/tree-sitter-agda-*/* ${PORTAGE_BUILDDIR}/work/helix-0.6.0/helix-syntax/languages/tree-sitter-agda/ || die
	cp -r -f -n ${PORTAGE_BUILDDIR}/work/tree-sitter-bash-*/* ${PORTAGE_BUILDDIR}/work/helix-0.6.0/helix-syntax/languages/tree-sitter-bash/ || die
	cp -r -f -n ${PORTAGE_BUILDDIR}/work/tree-sitter-c-*/* ${PORTAGE_BUILDDIR}/work/helix-0.6.0/helix-syntax/languages/tree-sitter-c/ || die
	cp -r -f -n ${PORTAGE_BUILDDIR}/work/tree-sitter-cmake-*/* ${PORTAGE_BUILDDIR}/work/helix-0.6.0/helix-syntax/languages/tree-sitter-cmake/ || die
	cp -r -f -n ${PORTAGE_BUILDDIR}/work/tree-sitter-comment-*/* ${PORTAGE_BUILDDIR}/work/helix-0.6.0/helix-syntax/languages/tree-sitter-comment/ || die
	cp -r -f -n ${PORTAGE_BUILDDIR}/work/tree-sitter-cpp-*/* ${PORTAGE_BUILDDIR}/work/helix-0.6.0/helix-syntax/languages/tree-sitter-cpp/ || die
	cp -r -f -n ${PORTAGE_BUILDDIR}/work/tree-sitter-c-sharp-*/* ${PORTAGE_BUILDDIR}/work/helix-0.6.0/helix-syntax/languages/tree-sitter-c-sharp/ || die
	cp -r -f -n ${PORTAGE_BUILDDIR}/work/tree-sitter-css-*/* ${PORTAGE_BUILDDIR}/work/helix-0.6.0/helix-syntax/languages/tree-sitter-css/ || die
	cp -r -f -n ${PORTAGE_BUILDDIR}/work/tree-sitter-dart-*/* ${PORTAGE_BUILDDIR}/work/helix-0.6.0/helix-syntax/languages/tree-sitter-dart/ || die
	cp -r -f -n ${PORTAGE_BUILDDIR}/work/tree-sitter-dockerfile-*/* ${PORTAGE_BUILDDIR}/work/helix-0.6.0/helix-syntax/languages/tree-sitter-dockerfile/ || die
	cp -r -f -n ${PORTAGE_BUILDDIR}/work/tree-sitter-elixir-*/* ${PORTAGE_BUILDDIR}/work/helix-0.6.0/helix-syntax/languages/tree-sitter-elixir/ || die
	cp -r -f -n ${PORTAGE_BUILDDIR}/work/tree-sitter-fish-*/* ${PORTAGE_BUILDDIR}/work/helix-0.6.0/helix-syntax/languages/tree-sitter-fish/ || die
	cp -r -f -n ${PORTAGE_BUILDDIR}/work/tree-sitter-git-commit-*/* ${PORTAGE_BUILDDIR}/work/helix-0.6.0/helix-syntax/languages/tree-sitter-git-commit/ || die
	cp -r -f -n ${PORTAGE_BUILDDIR}/work/tree-sitter-git-diff-*/* ${PORTAGE_BUILDDIR}/work/helix-0.6.0/helix-syntax/languages/tree-sitter-git-diff/ || die
	cp -r -f -n ${PORTAGE_BUILDDIR}/work/tree-sitter-git-rebase-*/* ${PORTAGE_BUILDDIR}/work/helix-0.6.0/helix-syntax/languages/tree-sitter-git-rebase/ || die
	cp -r -f -n ${PORTAGE_BUILDDIR}/work/tree-sitter-glsl-*/* ${PORTAGE_BUILDDIR}/work/helix-0.6.0/helix-syntax/languages/tree-sitter-glsl/ || die
	cp -r -f -n ${PORTAGE_BUILDDIR}/work/tree-sitter-go-*/* ${PORTAGE_BUILDDIR}/work/helix-0.6.0/helix-syntax/languages/tree-sitter-go/ || die
	cp -r -f -n ${PORTAGE_BUILDDIR}/work/tree-sitter-haskell-*/* ${PORTAGE_BUILDDIR}/work/helix-0.6.0/helix-syntax/languages/tree-sitter-haskell/ || die
	cp -r -f -n ${PORTAGE_BUILDDIR}/work/tree-sitter-html-*/* ${PORTAGE_BUILDDIR}/work/helix-0.6.0/helix-syntax/languages/tree-sitter-html/ || die
	cp -r -f -n ${PORTAGE_BUILDDIR}/work/tree-sitter-java-*/* ${PORTAGE_BUILDDIR}/work/helix-0.6.0/helix-syntax/languages/tree-sitter-java/ || die
	cp -r -f -n ${PORTAGE_BUILDDIR}/work/tree-sitter-javascript-*/* ${PORTAGE_BUILDDIR}/work/helix-0.6.0/helix-syntax/languages/tree-sitter-javascript/ || die
	cp -r -f -n ${PORTAGE_BUILDDIR}/work/tree-sitter-json-*/* ${PORTAGE_BUILDDIR}/work/helix-0.6.0/helix-syntax/languages/tree-sitter-json/ || die
	cp -r -f -n ${PORTAGE_BUILDDIR}/work/tree-sitter-julia-*/* ${PORTAGE_BUILDDIR}/work/helix-0.6.0/helix-syntax/languages/tree-sitter-julia/ || die
	cp -r -f -n ${PORTAGE_BUILDDIR}/work/tree-sitter-latex-*/* ${PORTAGE_BUILDDIR}/work/helix-0.6.0/helix-syntax/languages/tree-sitter-latex/ || die
	cp -r -f -n ${PORTAGE_BUILDDIR}/work/tree-sitter-ledger-*/* ${PORTAGE_BUILDDIR}/work/helix-0.6.0/helix-syntax/languages/tree-sitter-ledger/ || die
	cp -r -f -n ${PORTAGE_BUILDDIR}/work/tree-sitter-llvm-*/* ${PORTAGE_BUILDDIR}/work/helix-0.6.0/helix-syntax/languages/tree-sitter-llvm/ || die
	cp -r -f -n ${PORTAGE_BUILDDIR}/work/tree-sitter-lua-*/* ${PORTAGE_BUILDDIR}/work/helix-0.6.0/helix-syntax/languages/tree-sitter-lua/ || die
	cp -r -f -n ${PORTAGE_BUILDDIR}/work/tree-sitter-markdown-*/* ${PORTAGE_BUILDDIR}/work/helix-0.6.0/helix-syntax/languages/tree-sitter-markdown/ || die
	cp -r -f -n ${PORTAGE_BUILDDIR}/work/tree-sitter-nix-*/* ${PORTAGE_BUILDDIR}/work/helix-0.6.0/helix-syntax/languages/tree-sitter-nix/ || die
	cp -r -f -n ${PORTAGE_BUILDDIR}/work/tree-sitter-ocaml-*/* ${PORTAGE_BUILDDIR}/work/helix-0.6.0/helix-syntax/languages/tree-sitter-ocaml/ || die
	cp -r -f -n ${PORTAGE_BUILDDIR}/work/tree-sitter-perl-*/* ${PORTAGE_BUILDDIR}/work/helix-0.6.0/helix-syntax/languages/tree-sitter-perl/ || die
	cp -r -f -n ${PORTAGE_BUILDDIR}/work/tree-sitter-php-*/* ${PORTAGE_BUILDDIR}/work/helix-0.6.0/helix-syntax/languages/tree-sitter-php/ || die
	cp -r -f -n ${PORTAGE_BUILDDIR}/work/tree-sitter-protobuf-*/* ${PORTAGE_BUILDDIR}/work/helix-0.6.0/helix-syntax/languages/tree-sitter-protobuf/ || die
	cp -r -f -n ${PORTAGE_BUILDDIR}/work/tree-sitter-python-*/* ${PORTAGE_BUILDDIR}/work/helix-0.6.0/helix-syntax/languages/tree-sitter-python/ || die
	cp -r -f -n ${PORTAGE_BUILDDIR}/work/tree-sitter-ruby-*/* ${PORTAGE_BUILDDIR}/work/helix-0.6.0/helix-syntax/languages/tree-sitter-ruby/ || die
	cp -r -f -n ${PORTAGE_BUILDDIR}/work/tree-sitter-rust-*/* ${PORTAGE_BUILDDIR}/work/helix-0.6.0/helix-syntax/languages/tree-sitter-rust/ || die
	cp -r -f -n ${PORTAGE_BUILDDIR}/work/tree-sitter-scala-*/* ${PORTAGE_BUILDDIR}/work/helix-0.6.0/helix-syntax/languages/tree-sitter-scala/ || die
	cp -r -f -n ${PORTAGE_BUILDDIR}/work/tree-sitter-svelte-*/* ${PORTAGE_BUILDDIR}/work/helix-0.6.0/helix-syntax/languages/tree-sitter-svelte/ || die
	cp -r -f -n ${PORTAGE_BUILDDIR}/work/tree-sitter-swift-*/* ${PORTAGE_BUILDDIR}/work/helix-0.6.0/helix-syntax/languages/tree-sitter-swift/ || die
	cp -r -f -n ${PORTAGE_BUILDDIR}/work/tree-sitter-toml-*/* ${PORTAGE_BUILDDIR}/work/helix-0.6.0/helix-syntax/languages/tree-sitter-toml/ || die
	cp -r -f -n ${PORTAGE_BUILDDIR}/work/tree-sitter-tablegen-*/* ${PORTAGE_BUILDDIR}/work/helix-0.6.0/helix-syntax/languages/tree-sitter-tablegen/ || die
	cp -r -f -n ${PORTAGE_BUILDDIR}/work/tree-sitter-tsq-*/* ${PORTAGE_BUILDDIR}/work/helix-0.6.0/helix-syntax/languages/tree-sitter-tsq/ || die
	cp -r -f -n ${PORTAGE_BUILDDIR}/work/tree-sitter-typescript-*/* ${PORTAGE_BUILDDIR}/work/helix-0.6.0/helix-syntax/languages/tree-sitter-typescript/ || die
	cp -r -f -n ${PORTAGE_BUILDDIR}/work/tree-sitter-vue-*/* ${PORTAGE_BUILDDIR}/work/helix-0.6.0/helix-syntax/languages/tree-sitter-vue/ || die
	cp -r -f -n ${PORTAGE_BUILDDIR}/work/tree-sitter-wgsl-*/* ${PORTAGE_BUILDDIR}/work/helix-0.6.0/helix-syntax/languages/tree-sitter-wgsl/ || die
	cp -r -f -n ${PORTAGE_BUILDDIR}/work/tree-sitter-yaml-*/* ${PORTAGE_BUILDDIR}/work/helix-0.6.0/helix-syntax/languages/tree-sitter-yaml/ || die
	cp -r -f -n ${PORTAGE_BUILDDIR}/work/tree-sitter-zig-*/* ${PORTAGE_BUILDDIR}/work/helix-0.6.0/helix-syntax/languages/tree-sitter-zig/ || die
	eapply_user
}

src_configure() {
	sed -i "s!%%DATADIR%%!${EPREFIX}/usr/share/helix!" helix-core/src/lib.rs || die
}

src_compile() {
	cargo_src_compile
}

src_install() {
	insinto /usr/share/helix
	doins -r runtime
	use doc && dodoc README.md CHANGELOG.md
	use doc && dodoc -r docs/
	cargo_src_install --path helix-term
}
