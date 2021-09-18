# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	ahash-0.3.8
	aho-corasick-0.7.13
	anyhow-1.0.32
	arrayref-0.3.6
	arrayvec-0.5.1
	atty-0.2.14
	autocfg-1.0.0
	base64-0.11.0
	bitflags-1.2.1
	blake2b_simd-0.5.10
	cc-1.0.58
	cfg-if-0.1.10
	chrono-0.4.13
	clap-3.0.0-beta.2
	clap_derive-3.0.0-beta.2
	confy-0.4.0
	constant_time_eq-0.1.5
	crossbeam-deque-0.7.3
	crossbeam-epoch-0.8.2
	crossbeam-queue-0.2.3
	crossbeam-utils-0.7.2
	directories-2.0.2
	dirs-2.0.2
	dirs-sys-0.3.5
	dlv-list-0.2.2
	doc-comment-0.3.3
	either-1.5.3
	getrandom-0.1.14
	git2-0.13.8
	hashbrown-0.7.2
	hashbrown-0.9.1
	heck-0.3.1
	hermit-abi-0.1.15
	hostname-0.3.1
	humantime-2.0.1
	humantime-serde-1.0.0
	idna-0.2.0
	indexmap-1.6.0
	jobserver-0.1.21
	lazy_static-1.4.0
	libc-0.2.74
	libgit2-sys-0.12.9+1.0.1
	libssh2-sys-0.2.18
	libz-sys-1.0.25
	log-0.4.11
	match_cfg-0.1.0
	matches-0.1.8
	maybe-uninit-2.0.0
	memchr-2.3.3
	memoffset-0.5.5
	ntapi-0.3.4
	num-integer-0.1.43
	num-traits-0.2.12
	num_cpus-1.13.0
	once_cell-1.4.0
	openssl-probe-0.1.2
	openssl-sys-0.9.58
	ordered-multimap-0.2.4
	os_str_bytes-2.4.0
	percent-encoding-2.1.0
	pkg-config-0.3.18
	ppv-lite86-0.2.8
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro2-1.0.19
	quote-1.0.7
	rand-0.7.3
	rand_chacha-0.2.2
	rand_core-0.5.1
	rand_hc-0.2.0
	rayon-1.3.1
	rayon-core-1.7.1
	redox_syscall-0.1.57
	redox_users-0.3.4
	regex-1.3.9
	regex-syntax-0.6.18
	rust-argon2-0.7.0
	rust-ini-0.15.3
	scopeguard-1.1.0
	serde-1.0.114
	serde_derive-1.0.114
	shellexpand-2.0.0
	strsim-0.10.0
	syn-1.0.37
	sysinfo-0.15.0
	termcolor-1.1.2
	textwrap-0.12.1
	thread_local-1.0.1
	time-0.1.43
	tinyvec-0.3.3
	toml-0.5.6
	unicode-bidi-0.3.4
	unicode-normalization-0.1.13
	unicode-segmentation-1.7.0
	unicode-width-0.1.8
	unicode-xid-0.2.1
	url-2.1.1
	users-0.10.0
	vcpkg-0.2.10
	vec_map-0.8.2
	version_check-0.9.2
	wasi-0.9.0+wasi-snapshot-preview1
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
"

inherit cargo flag-o-matic

DESCRIPTION="A cross-shell customizable powerline-like prompt with icons"
# Double check the homepage as the cargo_metadata crate
# does not provide this value so instead repository is used
HOMEPAGE="https://github.com/reujab/silver"
SRC_URI="https://github.com/reujab/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" $(cargo_crate_uris ${CRATES})"

LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 CC0-1.0 MIT Unlicense ZLIB"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="virtual/pkgconfig"
DEPEND="
	>=dev-libs/libgit2-1.1.0:=[threads]
"

DOCS="readme.md"

PATCHES=( "$FILESDIR/add-gentoo-support.patch" )

src_configure() {
	export LIBGIT2_SYS_USE_PKG_CONFIG=1
	export PKG_CONFIG_ALLOW_CROSS=1

	# Some obscure LDFLAGS cause error during linking
	strip-flags
}

src_install() {
	cargo_src_install

	einstalldocs
}

pkg_postinst() {
	elog
	elog "To use ${PN} with the custom icons (which are enable by default)"
	elog "you must patch your font or install a nerd font"
	elog "Visit https://www.nerdfonts.com/font-downloads to download one."
	elog
}
