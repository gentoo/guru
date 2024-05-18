# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	addr2line@0.20.0
	adler@1.0.2
	aho-corasick@1.0.2
	atty@0.2.14
	autocfg@1.1.0
	backtrace@0.3.68
	base64@0.13.1
	base64@0.21.2
	bitflags@1.3.2
	bitflags@2.3.3
	bumpalo@3.13.0
	bytes@1.4.0
	cc@1.0.82
	cfg-if@1.0.0
	clap@3.2.25
	clap_derive@3.2.25
	clap_lex@0.2.4
	colored@2.0.4
	core-foundation-sys@0.8.4
	core-foundation@0.9.3
	dirs-next@2.0.0
	dirs-sys-next@0.1.2
	edit-distance@2.1.0
	encoding_rs@0.8.32
	env_logger@0.7.1
	errno-dragonfly@0.1.2
	errno@0.3.2
	fastrand@2.0.0
	fnv@1.0.7
	foreign-types-shared@0.1.1
	foreign-types@0.3.2
	form_urlencoded@1.2.0
	futures-channel@0.3.28
	futures-core@0.3.28
	futures-executor@0.3.28
	futures-io@0.3.28
	futures-macro@0.3.28
	futures-sink@0.3.28
	futures-task@0.3.28
	futures-util@0.3.28
	futures@0.3.28
	fuzzy-matcher@0.3.7
	getrandom@0.2.10
	gimli@0.27.3
	git2@0.17.2
	h2@0.3.20
	hashbrown@0.12.3
	heck@0.4.1
	hermit-abi@0.1.19
	hermit-abi@0.3.2
	http-body@0.4.5
	http@0.2.9
	httparse@1.8.0
	httpdate@1.0.2
	humantime@1.3.0
	hyper-tls@0.5.0
	hyper@0.14.27
	idna@0.4.0
	indexmap@1.9.3
	ipnet@2.8.0
	is-terminal@0.4.9
	itoa@1.0.9
	jobserver@0.1.26
	js-sys@0.3.64
	lazy_static@1.4.0
	leftwm-core@0.4.2
	libc@0.2.147
	libgit2-sys@0.15.2+1.6.4
	libssh2-sys@0.3.0
	libz-sys@1.1.12
	linux-raw-sys@0.4.5
	log@0.4.19
	memchr@2.5.0
	memoffset@0.7.1
	mime@0.3.17
	miniz_oxide@0.7.1
	mio@0.8.8
	native-tls@0.2.11
	nix@0.26.2
	num_cpus@1.16.0
	object@0.31.1
	once_cell@1.18.0
	openssl-macros@0.1.1
	openssl-probe@0.1.5
	openssl-src@111.27.0+1.1.1v
	openssl-sys@0.9.91
	openssl@0.10.56
	os_str_bytes@6.5.1
	percent-encoding@2.3.0
	pin-project-lite@0.2.11
	pin-utils@0.1.0
	pkg-config@0.3.27
	pretty_env_logger@0.4.0
	proc-macro-error-attr@1.0.4
	proc-macro-error@1.0.4
	proc-macro2@1.0.66
	quick-error@1.2.3
	quote@1.0.32
	redox_syscall@0.2.16
	redox_syscall@0.3.5
	redox_users@0.4.3
	regex-automata@0.3.6
	regex-syntax@0.7.4
	regex@1.9.3
	reqwest@0.11.18
	ron@0.8.0
	rustc-demangle@0.1.23
	rustix@0.38.7
	ryu@1.0.15
	schannel@0.1.22
	security-framework-sys@2.9.1
	security-framework@2.9.2
	semver@1.0.18
	serde@1.0.183
	serde_derive@1.0.183
	serde_json@1.0.104
	serde_urlencoded@0.7.1
	signal-hook-registry@1.4.1
	signal-hook@0.3.17
	slab@0.4.8
	socket2@0.4.9
	static_assertions@1.1.0
	strsim@0.10.0
	syn@1.0.109
	syn@2.0.28
	tempfile@3.7.1
	termcolor@1.2.0
	textwrap@0.16.0
	thiserror-impl@1.0.44
	thiserror@1.0.44
	thread_local@1.1.7
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	tokio-macros@2.1.0
	tokio-native-tls@0.3.1
	tokio-util@0.7.8
	tokio@1.29.1
	toml@0.5.11
	tower-service@0.3.2
	tracing-attributes@0.1.26
	tracing-core@0.1.31
	tracing@0.1.37
	try-lock@0.2.4
	unicode-bidi@0.3.13
	unicode-ident@1.0.11
	unicode-normalization@0.1.22
	url@2.4.0
	vcpkg@0.2.15
	version_check@0.9.4
	want@0.3.1
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.87
	wasm-bindgen-futures@0.4.37
	wasm-bindgen-macro-support@0.2.87
	wasm-bindgen-macro@0.2.87
	wasm-bindgen-shared@0.2.87
	wasm-bindgen@0.2.87
	web-sys@0.3.64
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.5
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-sys@0.48.0
	windows-targets@0.48.1
	windows_aarch64_gnullvm@0.48.0
	windows_aarch64_msvc@0.48.0
	windows_i686_gnu@0.48.0
	windows_i686_msvc@0.48.0
	windows_x86_64_gnu@0.48.0
	windows_x86_64_gnullvm@0.48.0
	windows_x86_64_msvc@0.48.0
	winreg@0.10.1
	x11-dl@2.21.0
	xdg@2.5.2
"

inherit cargo

DESCRIPTION="A theme mangager for LeftWM"
HOMEPAGE="https://github.com/leftwm/leftwm-theme"
# The version has to be hardcoded for now because of it being a release candidate
# and portage doesn't understand "0.1.2-rc.1" as a version
SRC_URI="
	https://github.com/leftwm/leftwm-theme/archive/refs/tags/v0.1.2-rc.1.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+=" Apache-2.0 BSD MIT MPL-2.0 Unicode-DFS-2016"
SLOT="0"
KEYWORDS="~amd64"

QA_FLAGS_IGNORED="usr/bin/leftwm-theme"

DEPEND="
	dev-libs/openssl
	sys-libs/zlib
"

RDEPEND="
	${DEPEND}
"

# This won't be necessary in a normal, no-pre-release version
src_unpack() {
	unpack ${A}
	mv leftwm-theme-0.1.2-rc.1 leftwm-theme-0.1.2_rc1 || die
	cargo_gen_config
	cargo_src_unpack
}

src_test() {
	# leftwm-theme requires an internet connection pass "test_update_repos"
	# unfortunately it doesn't look like that there's an option to skip particular tests in cargo.eclass
	cargo test $(usex debug "" --release) ${ECARGO_ARGS[@]} "$@" -- --skip test_update_repos
	einfo "${@}"
	"${@}" || die "cargo test failed"
}

src_install() {
	dodoc README.md
	cd target/$(usex debug debug release) || die
	dobin leftwm-theme
}
