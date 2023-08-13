# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	aho-corasick@0.7.19
	android_system_properties@0.1.5
	ansi-to-tui@2.0.0
	anyhow@1.0.65
	atty@0.2.14
	autocfg@1.1.0
	bitflags@1.3.2
	block@0.1.6
	bumpalo@3.11.0
	byteorder@1.4.3
	bytesize@1.1.0
	cassowary@0.3.0
	cc@1.0.73
	cfg-if@0.1.10
	cfg-if@1.0.0
	chrono@0.4.22
	clap@4.0.32
	clap_derive@4.0.21
	clap_lex@0.3.0
	cocoa@0.20.2
	color-to-tui@0.2.0
	colored@2.0.0
	com@0.6.0
	com_macros@0.6.0
	com_macros_support@0.6.0
	core-foundation-sys@0.7.0
	core-foundation-sys@0.8.3
	core-foundation@0.7.0
	core-foundation@0.9.3
	core-graphics-types@0.1.1
	core-graphics@0.19.2
	core-graphics@0.22.3
	core-video-sys@0.1.4
	crossterm@0.25.0
	crossterm_winapi@0.9.0
	dirs-sys@0.3.7
	dirs@4.0.0
	either@1.8.0
	enum-iterator-derive@1.1.0
	enum-iterator@1.1.3
	errno-dragonfly@0.1.2
	errno@0.2.8
	foreign-types-shared@0.1.1
	foreign-types@0.3.2
	form_urlencoded@1.1.0
	futures-channel@0.3.24
	futures-core@0.3.24
	futures-executor@0.3.24
	futures-io@0.3.24
	futures-macro@0.3.24
	futures-sink@0.3.24
	futures-task@0.3.24
	futures-util@0.3.24
	futures@0.3.24
	gethostname@0.2.3
	getrandom@0.2.7
	getset@0.1.2
	git2@0.14.4
	heck@0.4.0
	hermit-abi@0.1.19
	hermit-abi@0.2.6
	home@0.5.3
	iana-time-zone@0.1.48
	idna@0.3.0
	if-addrs-sys@0.3.2
	if-addrs@0.6.7
	io-lifetimes@1.0.3
	is-terminal@0.4.2
	itertools@0.10.4
	itoa@1.0.3
	jobserver@0.1.24
	js-sys@0.3.60
	lazy_static@1.4.0
	libc@0.2.139
	libgit2-sys@0.13.4+1.4.2
	libmacchina@6.3.5
	libz-sys@1.1.8
	linux-raw-sys@0.1.4
	local-ip-address@0.4.8
	lock_api@0.4.8
	log@0.4.17
	mach@0.3.2
	malloc_buf@0.0.6
	memchr@2.5.0
	memoffset@0.6.5
	metal@0.18.0
	minimal-lexical@0.2.1
	mio@0.8.4
	neli@0.5.3
	nix@0.24.2
	nom@7.1.1
	num-integer@0.1.45
	num-traits@0.2.15
	num_cpus@1.13.1
	num_threads@0.1.6
	objc@0.2.7
	objc_exception@0.1.2
	once_cell@1.14.0
	os-release@0.1.0
	os_str_bytes@6.3.0
	parking_lot@0.12.1
	parking_lot_core@0.9.3
	percent-encoding@2.2.0
	pin-project-lite@0.2.9
	pin-utils@0.1.0
	pkg-config@0.3.25
	ppv-lite86@0.2.16
	proc-macro-error-attr@1.0.4
	proc-macro-error@1.0.4
	proc-macro2@1.0.49
	quote@1.0.21
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	redox_syscall@0.2.16
	redox_users@0.4.3
	regex-syntax@0.6.27
	regex@1.6.0
	rustc_version@0.4.0
	rustix@0.36.6
	rustversion@1.0.9
	ryu@1.0.11
	same-file@1.0.6
	scopeguard@1.1.0
	semver@1.0.14
	serde@1.0.152
	serde_derive@1.0.152
	serde_json@1.0.91
	shellexpand@3.0.0
	signal-hook-mio@0.2.3
	signal-hook-registry@1.4.0
	signal-hook@0.3.14
	slab@0.4.7
	smallvec@1.9.0
	sqlite3-src@0.4.0
	sqlite3-sys@0.14.0
	sqlite@0.27.0
	strsim@0.10.0
	syn@1.0.107
	sysctl@0.4.6
	termcolor@1.1.3
	thiserror-impl@1.0.38
	thiserror@1.0.38
	time@0.1.44
	time@0.3.14
	tinyvec@1.6.0
	tinyvec_macros@0.1.0
	toml@0.5.10
	tui@0.19.0
	unicode-bidi@0.3.8
	unicode-ident@1.0.4
	unicode-normalization@0.1.22
	unicode-segmentation@1.10.0
	unicode-width@0.1.10
	url@2.3.1
	vcpkg@0.2.15
	vergen@7.4.2
	version_check@0.9.4
	walkdir@2.3.2
	wasi@0.10.0+wasi-snapshot-preview1
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.83
	wasm-bindgen-macro-support@0.2.83
	wasm-bindgen-macro@0.2.83
	wasm-bindgen-shared@0.2.83
	wasm-bindgen@0.2.83
	widestring@1.0.2
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.5
	winapi-wsapoll@0.1.1
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-sys@0.36.1
	windows-sys@0.42.0
	windows@0.39.0
	windows_aarch64_gnullvm@0.42.0
	windows_aarch64_msvc@0.36.1
	windows_aarch64_msvc@0.39.0
	windows_aarch64_msvc@0.42.0
	windows_i686_gnu@0.36.1
	windows_i686_gnu@0.39.0
	windows_i686_gnu@0.42.0
	windows_i686_msvc@0.36.1
	windows_i686_msvc@0.39.0
	windows_i686_msvc@0.42.0
	windows_x86_64_gnu@0.36.1
	windows_x86_64_gnu@0.39.0
	windows_x86_64_gnu@0.42.0
	windows_x86_64_gnullvm@0.42.0
	windows_x86_64_msvc@0.36.1
	windows_x86_64_msvc@0.39.0
	windows_x86_64_msvc@0.42.0
	winreg@0.10.1
	wmi@0.11.2
	x11rb-protocol@0.10.0
	x11rb@0.10.1
"

inherit cargo xdg-utils

SRC_URI="
	https://github.com/Macchina-CLI/macchina/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

DESCRIPTION="A system information fetcher, with an (unhealthy) emphasis on performance."
HOMEPAGE="https://github.com/Macchina-CLI/macchina"
LICENSE="
	BSD
	MIT
	Apache-2.0
	MPL-2.0
"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	app-portage/portage-utils:0=
	dev-libs/libgit2:0=
"
RDEPEND="${DEPEND}"

QA_FLAGS_IGNORED="usr/bin/macchina"

src_compile() {
	cargo_src_compile
}

src_install() {
	dodoc CHANGELOG.md README.md

	if use debug; then
		cd target/debug || die "Couldn't cd into target/debug"
	else
		cd target/release || die "Couldn't cd into target/release"
	fi

	dobin macchina
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
