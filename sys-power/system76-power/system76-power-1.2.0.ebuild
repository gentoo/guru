# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

CRATES="
	addr2line@0.21.0
	adler@1.0.2
	aho-corasick@1.1.3
	anstream@0.6.13
	anstyle@1.0.6
	anstyle-parse@0.2.3
	anstyle-query@1.0.2
	anstyle-wincon@3.0.2
	anyhow@1.0.82
	async-broadcast@0.5.1
	async-channel@2.2.1
	async-executor@1.11.0
	async-fs@1.6.0
	async-io@1.13.0
	async-io@2.3.2
	async-lock@2.8.0
	async-lock@3.3.0
	async-process@1.8.1
	async-recursion@1.1.1
	async-signal@0.2.6
	async-task@4.7.0
	async-trait@0.1.80
	atomic-waker@1.1.2
	autocfg@1.2.0
	backtrace@0.3.71
	bitflags@1.3.2
	bitflags@2.5.0
	block-buffer@0.10.4
	blocking@1.5.1
	byteorder@1.5.0
	bytes@1.6.0
	cc@1.0.95
	cfg-if@1.0.0
	clap@4.5.4
	clap_builder@4.5.2
	clap_derive@4.5.4
	clap_lex@0.7.0
	colorchoice@1.0.0
	concat-in-place@1.1.0
	concurrent-queue@2.4.0
	cpufeatures@0.2.12
	crossbeam-utils@0.8.19
	crypto-common@0.1.6
	darling@0.20.8
	darling_core@0.20.8
	darling_macro@0.20.8
	derivative@2.2.0
	derive_setters@0.1.6
	digest@0.10.7
	enumflags2@0.7.9
	enumflags2_derive@0.7.9
	equivalent@1.0.1
	errno@0.3.8
	event-listener@2.5.3
	event-listener@3.1.0
	event-listener@4.0.3
	event-listener@5.3.0
	event-listener-strategy@0.4.0
	event-listener-strategy@0.5.1
	fastrand@1.9.0
	fastrand@2.0.2
	fern@0.6.2
	fnv@1.0.7
	futures-core@0.3.30
	futures-io@0.3.30
	futures-lite@1.13.0
	futures-lite@2.3.0
	futures-sink@0.3.30
	futures-task@0.3.30
	futures-util@0.3.30
	generic-array@0.14.7
	getrandom@0.2.14
	gimli@0.28.1
	hashbrown@0.14.3
	heck@0.5.0
	hermit-abi@0.3.9
	hex@0.4.3
	hidapi@1.5.0
	ident_case@1.0.1
	indexmap@2.2.6
	inotify@0.10.2
	inotify-sys@0.1.5
	instant@0.1.12
	intel-pstate@1.0.1
	io-lifetimes@1.0.11
	itoa@1.0.11
	libc@0.2.153
	linux-raw-sys@0.3.8
	linux-raw-sys@0.4.13
	log@0.4.21
	memchr@2.7.2
	memoffset@0.7.1
	memoffset@0.9.1
	miniz_oxide@0.7.2
	mio@0.8.11
	nix@0.26.4
	numtoa@0.2.4
	object@0.32.2
	once_cell@1.19.0
	ordered-stream@0.2.0
	parking@2.2.0
	pin-project-lite@0.2.14
	pin-utils@0.1.0
	piper@0.2.1
	pkg-config@0.3.30
	polling@2.8.0
	polling@3.7.0
	ppv-lite86@0.2.17
	proc-macro-crate@1.3.1
	proc-macro2@1.0.81
	quote@1.0.36
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	regex@1.10.4
	regex-automata@0.4.6
	regex-syntax@0.8.3
	rustc-demangle@0.1.23
	rustix@0.37.27
	rustix@0.38.34
	ryu@1.0.17
	serde@1.0.199
	serde_derive@1.0.199
	serde_json@1.0.116
	serde_repr@0.1.19
	sha1@0.10.6
	signal-hook-registry@1.4.2
	slab@0.4.9
	smart-default@0.6.0
	socket2@0.4.10
	socket2@0.5.6
	static_assertions@1.1.0
	strsim@0.10.0
	strsim@0.11.1
	syn@1.0.109
	syn@2.0.60
	sysfs-class@0.1.3
	tempfile@3.10.1
	thiserror@1.0.59
	thiserror-impl@1.0.59
	tokio@1.37.0
	tokio-macros@2.2.0
	toml_datetime@0.6.5
	toml_edit@0.19.15
	tracing@0.1.40
	tracing-attributes@0.1.27
	tracing-core@0.1.32
	typenum@1.17.0
	uds_windows@1.1.0
	unicode-ident@1.0.12
	utf8parse@0.2.1
	version_check@0.9.4
	waker-fn@1.1.1
	wasi@0.11.0+wasi-snapshot-preview1
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-targets@0.48.5
	windows-targets@0.52.5
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.5
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.5
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.5
	windows_i686_gnullvm@0.52.5
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.5
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.5
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.5
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.5
	winnow@0.5.40
	xdg-home@1.1.0
	zbus@3.15.2
	zbus_macros@3.15.2
	zbus_names@2.6.1
	zbus_polkit@3.0.1
	zvariant@3.15.2
	zvariant_derive@3.15.2
	zvariant_utils@1.0.1
"

inherit cargo

DESCRIPTION="System76 Power Management Tool"
HOMEPAGE="https://github.com/pop-os/system76-power"

SRC_URI="
	https://github.com/pop-os/system76-power/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris)
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="systemd"
DEPEND="sys-apps/systemd"
RDEPEND="${DEPEND}"
BDEPEND="virtual/rust"

src_unpack() {
	cargo_src_unpack
}

src_prepare() {
	default
	# Replace dynamic git dependency of 'sysfs-class' with a static one
	sed -i 's|sysfs-class = { git = "https://github.com/pop-os/sysfs-class" }|sysfs-class = "0.1.3"|' Cargo.toml
	cargo_gen_config
}

src_configure() {
	cargo_src_configure
}

src_compile() {
	cargo_src_compile
}

src_install() {
	default
	elog "Enable the service: 'systemctl enable --now com.system76.PowerDaemon.service'"
}
