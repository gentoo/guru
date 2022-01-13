# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	aho-corasick-0.7.18
	ansi-to-tui-0.4.1
	ansi_term-0.12.1
	anyhow-1.0.52
	atty-0.2.14
	autocfg-1.0.1
	bitflags-1.2.1
	byteorder-1.4.3
	bytesize-1.1.0
	cassowary-0.3.0
	cc-1.0.72
	cfg-if-1.0.0
	chrono-0.4.19
	clap-2.34.0
	color-to-tui-0.1.3
	colored-2.0.0
	const-sha1-0.2.0
	core-foundation-0.9.2
	core-foundation-sys-0.8.3
	core-graphics-0.22.3
	core-graphics-types-0.1.1
	crossterm-0.20.0
	crossterm_winapi-0.8.0
	dirs-4.0.0
	dirs-next-2.0.0
	dirs-sys-0.3.6
	dirs-sys-next-0.1.2
	either-1.6.1
	enum-iterator-0.7.0
	enum-iterator-derive-0.7.0
	foreign-types-0.3.2
	foreign-types-shared-0.1.1
	form_urlencoded-1.0.1
	gethostname-0.2.1
	getrandom-0.2.3
	getset-0.1.2
	git2-0.13.25
	heck-0.3.3
	hermit-abi-0.1.19
	home-0.5.3
	idna-0.2.3
	if-addrs-0.6.7
	if-addrs-sys-0.3.2
	instant-0.1.12
	itertools-0.10.3
	itoa-1.0.1
	jobserver-0.1.24
	lazy_static-1.4.0
	libc-0.2.112
	libgit2-sys-0.12.26+1.3.0
	libmacchina-6.0.0
	libz-sys-1.1.3
	local-ip-address-0.4.4
	lock_api-0.4.5
	log-0.4.14
	mach-0.3.2
	matches-0.1.9
	memalloc-0.1.0
	memchr-2.4.1
	memoffset-0.6.5
	mio-0.7.14
	miow-0.3.7
	neli-0.5.3
	nix-0.22.2
	nix-0.23.1
	ntapi-0.3.6
	num-integer-0.1.44
	num-traits-0.2.14
	num_cpus-1.13.1
	os-release-0.1.0
	parking_lot-0.11.2
	parking_lot_core-0.8.5
	percent-encoding-2.1.0
	pkg-config-0.3.24
	ppv-lite86-0.2.16
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro2-1.0.36
	quote-1.0.14
	rand-0.8.4
	rand_chacha-0.3.1
	rand_core-0.6.3
	rand_hc-0.3.1
	redox_syscall-0.2.10
	redox_users-0.4.0
	regex-1.5.4
	regex-syntax-0.6.25
	rustc_version-0.4.0
	rustversion-1.0.6
	ryu-1.0.9
	same-file-1.0.6
	scopeguard-1.1.0
	semver-1.0.4
	serde-1.0.132
	serde_derive-1.0.132
	serde_json-1.0.73
	shellexpand-2.1.0
	signal-hook-0.3.13
	signal-hook-mio-0.2.1
	signal-hook-registry-1.4.0
	smallvec-1.7.0
	sqlite-0.26.0
	sqlite3-src-0.3.0
	sqlite3-sys-0.13.0
	strsim-0.8.0
	structopt-0.3.25
	structopt-derive-0.4.18
	syn-1.0.84
	sysctl-0.4.3
	textwrap-0.11.0
	thiserror-1.0.30
	thiserror-impl-1.0.30
	time-0.1.43
	tinyvec-1.5.1
	tinyvec_macros-0.1.0
	toml-0.5.8
	tui-0.16.0
	unicode-bidi-0.3.7
	unicode-normalization-0.1.19
	unicode-segmentation-1.8.0
	unicode-width-0.1.9
	unicode-xid-0.2.2
	url-2.2.2
	vcpkg-0.2.15
	vec_map-0.8.2
	vergen-6.0.0
	version_check-0.9.4
	walkdir-2.3.2
	wasi-0.10.2+wasi-snapshot-preview1
	widestring-0.5.1
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-wsapoll-0.1.1
	winapi-x86_64-pc-windows-gnu-0.4.0
	windows-0.18.0
	windows-0.29.0
	windows_aarch64_msvc-0.29.0
	windows_gen-0.18.0
	windows_i686_gnu-0.29.0
	windows_i686_msvc-0.29.0
	windows_macros-0.18.0
	windows_x86_64_gnu-0.29.0
	windows_x86_64_msvc-0.29.0
	winreg-0.10.1
	wmi-0.9.2
	x11rb-0.9.0
"

inherit cargo xdg-utils

SRC_URI="
	https://github.com/Macchina-CLI/macchina/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris)
"

DESCRIPTION="A system information fetcher, with an (unhealthy) emphasis on performance."
# Double check the homepage as the cargo_metadata crate
# does not provide this value so instead repository is used
HOMEPAGE="https://github.com/Macchina-CLI/macchina"
# License set may be more restrictive as OR is not respected
LICENSE="
	|| ( Apache-2.0 )
	|| ( Apache-2.0 MIT )
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

QA_FLAGS_IGNORED="usr/bin/.*"

IUSE="strip"

src_compile() {
	cargo_src_compile
}

src_install() {
	dodoc CHANGELOG.txt CONTRIBUTING.md README.md
	cd target/release || die
	if use strip ; then
		einfo "Strip macchina bin"
		strip macchina
	fi
	dobin macchina
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
