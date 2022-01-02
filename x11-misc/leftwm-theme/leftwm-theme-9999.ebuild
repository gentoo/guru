# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	aho-corasick-0.7.18
	atty-0.2.14
	autocfg-1.0.1
	base64-0.13.0
	bitflags-1.3.2
	bumpalo-3.7.1
	bytes-1.1.0
	cc-1.0.70
	cfg-if-1.0.0
	clap-3.0.0-beta.4
	clap_derive-3.0.0-beta.4
	colored-2.0.0
	core-foundation-0.9.1
	core-foundation-sys-0.8.2
	dirs-next-2.0.0
	dirs-sys-next-0.1.2
	edit-distance-2.1.0
	encoding_rs-0.8.28
	env_logger-0.7.1
	fnv-1.0.7
	foreign-types-0.3.2
	foreign-types-shared-0.1.1
	form_urlencoded-1.0.1
	futures-channel-0.3.17
	futures-core-0.3.17
	futures-io-0.3.17
	futures-sink-0.3.17
	futures-task-0.3.17
	futures-util-0.3.17
	fuzzy-matcher-0.3.7
	getrandom-0.2.3
	git2-0.13.23
	h2-0.3.6
	hashbrown-0.11.2
	heck-0.3.3
	hermit-abi-0.1.19
	http-0.2.5
	http-body-0.4.3
	httparse-1.5.1
	httpdate-1.0.1
	humantime-1.3.0
	hyper-0.14.13
	hyper-tls-0.5.0
	idna-0.2.3
	indexmap-1.7.0
	ipnet-2.3.1
	itoa-0.4.8
	jobserver-0.1.24
	js-sys-0.3.55
	lazy_static-1.4.0
	libc-0.2.103
	libgit2-sys-0.12.24+1.3.0
	libssh2-sys-0.2.21
	libz-sys-1.1.3
	log-0.4.14
	matches-0.1.9
	memchr-2.4.1
	mime-0.3.16
	mio-0.7.13
	miow-0.3.7
	native-tls-0.2.8
	ntapi-0.3.6
	num_cpus-1.13.0
	once_cell-1.8.0
	openssl-0.10.36
	openssl-probe-0.1.4
	openssl-sys-0.9.67
	os_str_bytes-3.1.0
	percent-encoding-2.1.0
	pin-project-lite-0.2.7
	pin-utils-0.1.0
	pkg-config-0.3.20
	ppv-lite86-0.2.10
	pretty_env_logger-0.4.0
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro2-1.0.29
	quick-error-1.2.3
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
	reqwest-0.11.4
	ryu-1.0.5
	schannel-0.1.19
	security-framework-2.4.2
	security-framework-sys-2.4.2
	semver-1.0.4
	serde-1.0.130
	serde_derive-1.0.130
	serde_json-1.0.68
	serde_urlencoded-0.7.0
	slab-0.4.4
	socket2-0.4.2
	strsim-0.10.0
	syn-1.0.78
	tempfile-3.2.0
	termcolor-1.1.2
	textwrap-0.14.2
	thread_local-1.1.3
	tinyvec-1.5.0
	tinyvec_macros-0.1.0
	tokio-1.12.0
	tokio-native-tls-0.3.0
	tokio-util-0.6.8
	toml-0.5.8
	tower-service-0.3.1
	tracing-0.1.28
	tracing-core-0.1.21
	try-lock-0.2.3
	unicode-bidi-0.3.6
	unicode-normalization-0.1.19
	unicode-segmentation-1.8.0
	unicode-width-0.1.9
	unicode-xid-0.2.2
	url-2.2.2
	vcpkg-0.2.15
	vec_map-0.8.2
	version_check-0.9.3
	want-0.3.0
	wasi-0.10.2+wasi-snapshot-preview1
	wasm-bindgen-0.2.78
	wasm-bindgen-backend-0.2.78
	wasm-bindgen-futures-0.4.28
	wasm-bindgen-macro-0.2.78
	wasm-bindgen-macro-support-0.2.78
	wasm-bindgen-shared-0.2.78
	web-sys-0.3.55
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	winreg-0.7.0
	xdg-2.2.0
"

inherit cargo xdg-utils git-r3

DESCRIPTION="A theme mangager for LeftWM"
HOMEPAGE="https://github.com/leftwm/leftwm-theme"

EGIT_REPO_URI="https://github.com/leftwm/leftwm-theme.git"

SLOT="0"

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
	BSD
"

QA_FLAGS_IGNORED="usr/bin/.*"

DEPEND="
	dev-libs/openssl
	sys-libs/zlib
	>=dev-lang/rust-1.52.0
"

RDEPEND="
	${DEPEND}
"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_compile() {
	cargo_src_compile
}

src_install() {
	dodoc README.md
	cd target/release || die
	dobin leftwm-theme
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
