# Copyright 2017-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Autogenerated by pycargoebuild 0.13.2

EAPI=8

CRATES="
	addr2line@0.21.0
	adler@1.0.2
	aho-corasick@1.1.1
	async-broadcast@0.5.1
	async-channel@1.9.0
	async-executor@1.5.4
	async-fs@1.6.0
	async-io@1.13.0
	async-lock@2.8.0
	async-process@1.8.1
	async-recursion@1.0.5
	async-signal@0.2.3
	async-task@4.4.1
	async-trait@0.1.73
	atomic-waker@1.1.2
	autocfg@1.1.0
	backtrace@0.3.69
	base64@0.21.4
	bencher@0.1.5
	bitflags@1.3.2
	bitflags@2.4.0
	block-buffer@0.10.4
	block@0.1.6
	blocking@1.4.1
	bumpalo@3.14.0
	byteorder@1.5.0
	bytes@1.5.0
	cc@1.0.83
	cfg-if@1.0.0
	concurrent-queue@2.3.0
	core-foundation-sys@0.8.4
	core-foundation@0.9.3
	cpufeatures@0.2.9
	crossbeam-utils@0.8.16
	crypto-common@0.1.6
	deranged@0.3.8
	derivative@2.2.0
	digest@0.10.7
	dirs-next@2.0.0
	dirs-sys-next@0.1.2
	dirs-sys@0.3.7
	dirs@4.0.0
	enumflags2@0.7.8
	enumflags2_derive@0.7.8
	env_logger@0.9.3
	equivalent@1.0.1
	errno-dragonfly@0.1.2
	errno@0.3.4
	event-listener@2.5.3
	event-listener@3.0.0
	fastrand@1.9.0
	fastrand@2.0.1
	foreign-types-shared@0.1.1
	foreign-types@0.3.2
	futures-core@0.3.28
	futures-io@0.3.28
	futures-lite@1.13.0
	futures-sink@0.3.28
	futures-task@0.3.28
	futures-util@0.3.28
	generic-array@0.14.7
	getrandom@0.2.10
	gimli@0.28.0
	hashbrown@0.12.3
	hashbrown@0.14.1
	hermit-abi@0.3.3
	hex@0.4.3
	indexmap@1.9.3
	indexmap@2.0.2
	instant@0.1.12
	io-lifetimes@1.0.11
	js-sys@0.3.64
	lazy_static@1.4.0
	libc@0.2.149
	linked-hash-map@0.5.6
	linux-raw-sys@0.3.8
	linux-raw-sys@0.4.8
	log@0.4.20
	mac-notification-sys@0.6.1
	malloc_buf@0.0.6
	memchr@2.6.4
	memoffset@0.7.1
	miniz_oxide@0.7.1
	mio@0.8.8
	native-tls@0.2.11
	nix@0.26.4
	notify-rust@4.9.0
	numtoa@0.1.0
	objc-foundation@0.1.1
	objc@0.2.7
	objc_id@0.1.1
	object@0.32.1
	once_cell@1.18.0
	openssl-macros@0.1.1
	openssl-probe@0.1.5
	openssl-sys@0.9.93
	openssl@0.10.57
	ordered-stream@0.2.0
	parking@2.1.1
	pin-project-lite@0.2.13
	pin-utils@0.1.0
	piper@0.2.1
	pkg-config@0.3.27
	polling@2.8.0
	ppv-lite86@0.2.17
	proc-macro-crate@1.3.1
	proc-macro2@1.0.68
	quick-xml@0.23.1
	quote@1.0.33
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	redox_syscall@0.2.16
	redox_syscall@0.3.5
	redox_termios@0.1.2
	redox_users@0.4.3
	regex-automata@0.3.9
	regex-syntax@0.7.5
	regex@1.9.6
	ring@0.16.20
	rustc-demangle@0.1.23
	rustc_tools_util@0.2.1
	rustix@0.37.24
	rustix@0.38.17
	rustls-native-certs@0.6.3
	rustls-pemfile@1.0.3
	rustls@0.20.9
	ryu@1.0.15
	schannel@0.1.22
	sct@0.7.0
	security-framework-sys@2.9.1
	security-framework@2.9.2
	serde@1.0.193
	serde_derive@1.0.193
	serde_repr@0.1.16
	serde_yaml@0.8.26
	sha1@0.10.6
	shell-words@1.1.0
	signal-hook-registry@1.4.1
	slab@0.4.9
	socket2@0.4.9
	socket2@0.5.4
	spin@0.5.2
	static_assertions@1.1.0
	syn@1.0.109
	syn@2.0.38
	tauri-winrt-notification@0.1.2
	tempfile@3.8.0
	termion@1.5.6
	thiserror-impl@1.0.49
	thiserror@1.0.49
	time-core@0.1.2
	time@0.1.45
	time@0.3.29
	tokio-macros@2.1.0
	tokio-native-tls@0.3.1
	tokio-rustls@0.23.4
	tokio-stream@0.1.14
	tokio@1.33.0
	toml_datetime@0.6.3
	toml_edit@0.19.15
	tracing-attributes@0.1.26
	tracing-core@0.1.31
	tracing@0.1.37
	typenum@1.17.0
	uds_windows@1.0.2
	unicode-ident@1.0.12
	unicode-width@0.1.11
	untrusted@0.7.1
	vcpkg@0.2.15
	version_check@0.9.4
	waker-fn@1.1.1
	wasi@0.10.0+wasi-snapshot-preview1
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.87
	wasm-bindgen-macro-support@0.2.87
	wasm-bindgen-macro@0.2.87
	wasm-bindgen-shared@0.2.87
	wasm-bindgen@0.2.87
	web-sys@0.3.64
	webpki@0.22.2
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-sys@0.48.0
	windows-targets@0.48.5
	windows@0.39.0
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_msvc@0.39.0
	windows_aarch64_msvc@0.48.5
	windows_i686_gnu@0.39.0
	windows_i686_gnu@0.48.5
	windows_i686_msvc@0.39.0
	windows_i686_msvc@0.48.5
	windows_x86_64_gnu@0.39.0
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_msvc@0.39.0
	windows_x86_64_msvc@0.48.5
	winnow@0.5.16
	xdg-home@1.0.0
	yaml-rust@0.4.5
	zbus@3.14.1
	zbus_macros@3.14.1
	zbus_names@2.6.0
	zvariant@3.15.0
	zvariant_derive@3.15.0
	zvariant_utils@1.0.1
"

inherit cargo

DESCRIPTION="IRC client written in Rust"
HOMEPAGE="https://github.com/osa1/tiny"
SRC_URI="
	https://github.com/osa1/tiny/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+=" Apache-2.0 BSD ISC MIT openssl Unicode-DFS-2016"
SLOT="0"
KEYWORDS="~amd64"
IUSE="dbus openssl"

DEPEND="
	dbus? ( sys-apps/dbus )
	openssl? ( dev-libs/openssl:= )
"
RDEPEND="${DEPEND}"

QA_FLAGS_IGNORED="usr/bin/tiny"

src_configure() {
	local myfeatures=(
		$(usex openssl tls-native tls-rustls)
		$(usev dbus desktop-notifications)
	)
	cargo_src_configure --no-default-features
}

src_install() {
	cargo_src_install --path crates/tiny
}
