# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	aho-corasick-0.7.18
	ansi_term-0.11.0
	anyhow-1.0.44
	anymap2-0.13.0
	arc-swap-1.3.2
	atty-0.2.14
	autocfg-1.0.1
	bitflags-1.2.1
	block-buffer-0.7.3
	block-padding-0.1.5
	byte-tools-0.3.1
	byteorder-1.4.3
	bytes-1.1.0
	cc-1.0.70
	cfg-if-1.0.0
	chrono-0.4.19
	clap-2.33.3
	crossbeam-channel-0.5.1
	crossbeam-utils-0.8.5
	digest-0.8.1
	dirs-3.0.2
	dirs-next-2.0.0
	dirs-sys-0.3.6
	dirs-sys-next-0.1.2
	doc-comment-0.3.3
	either-1.6.1
	fake-simd-0.1.2
	futures-0.3.17
	futures-channel-0.3.17
	futures-core-0.3.17
	futures-executor-0.3.17
	futures-io-0.3.17
	futures-macro-0.3.17
	futures-sink-0.3.17
	futures-task-0.3.17
	futures-util-0.3.17
	generic-array-0.12.4
	getrandom-0.2.3
	git-version-0.3.5
	git-version-macro-0.3.5
	hermit-abi-0.1.19
	itertools-0.10.1
	itoa-0.4.8
	kstring-1.0.4
	lazy_static-1.4.0
	libc-0.2.102
	libsystemd-sys-0.2.2
	liquid-0.23.0
	liquid-core-0.23.0
	liquid-derive-0.23.0
	liquid-lib-0.23.0
	log-0.4.14
	maplit-1.0.2
	memchr-2.4.1
	memoffset-0.6.4
	mio-0.7.13
	miow-0.3.7
	nix-0.20.1
	maybe-uninit-2.0.0
	ntapi-0.3.6
	num-integer-0.1.44
	num-traits-0.2.14
	num_cpus-1.13.0
	once_cell-1.8.0
	opaque-debug-0.2.3
	percent-encoding-2.1.0
	pest-2.1.3
	pest_derive-2.1.0
	pest_generator-2.1.3
	pest_meta-2.1.3
	pin-project-lite-0.2.7
	pin-utils-0.1.0
	pkg-config-0.3.19
	ppv-lite86-0.2.10
	proc-macro-hack-0.5.19
	proc-macro-nested-0.1.7
	proc-macro2-1.0.29
	proc-quote-0.4.0
	proc-quote-impl-0.3.2
	quote-1.0.9
	rand-0.8.4
	rand_chacha-0.3.1
	rand_core-0.6.3
	rand_hc-0.3.1
	redox_syscall-0.2.10
	redox_users-0.4.0
	regex-1.5.4
	regex-syntax-0.6.25
	remove_dir_all-0.5.3
	rustversion-1.0.5
	ryu-1.0.5
	serde-1.0.130
	serde_derive-1.0.130
	serde_json-1.0.68
	sha-1-0.8.2
	shellexpand-2.1.0
	signal-hook-0.3.10
	signal-hook-registry-1.4.0
	slab-0.4.4
	slog-2.7.0
	slog-async-2.7.0
	slog-envlogger-2.2.0
	slog-journald-2.1.1
	slog-scope-4.4.0
	slog-stdlog-4.1.0
	slog-term-2.8.0
	strsim-0.8.0
	syn-1.0.76
	take_mut-0.2.2
	tempfile-3.2.0
	term-0.7.0
	textwrap-0.11.0
	thiserror-1.0.29
	thiserror-impl-1.0.29
	thread_local-1.1.3
	time-0.1.44
	tokio-1.11.0
	tokio-macros-1.3.0
	toml-0.5.8
	typenum-1.14.0
	ucd-trie-0.1.3
	unicode-segmentation-1.8.0
	unicode-width-0.1.8
	unicode-xid-0.2.2
	vec_map-0.8.2
	wasi-0.10.0+wasi-snapshot-preview1
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-x86_64-pc-windows-gnu-0.4.0
	x11-dl-2.18.5
	xdg-2.2.0
"

inherit cargo xdg-utils

DESCRIPTION="A window manager for Adventurers"
HOMEPAGE="https://github.com/leftwm/leftwm"
SRC_URI="
	https://github.com/leftwm/leftwm/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
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
"
SLOT="0"
KEYWORDS="~amd64"
IUSE="systemd"

DEPEND="
	x11-libs/libXinerama:0=
	x11-apps/xrandr:0=
	x11-base/xorg-server:0=
"
RDEPEND="${DEPEND}"

QA_FLAGS_IGNORED="usr/bin/*"

src_compile() {
	cd leftwm || die
	use systemd && features="--features=journald"
	cargo_src_compile ${features}
}

src_install() {
	dodoc README.md CHANGELOG
	cp leftwm.desktop /usr/share/xsessions/ || die
	cd target/release || die
	dobin leftwm{,-worker,-state,-check,-command}
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
