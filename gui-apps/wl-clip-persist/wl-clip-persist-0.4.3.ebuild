# Copyright 2024 John M. Harris, Jr.
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	addr2line@0.21.0
	adler@1.0.2
	aho-corasick@1.1.3
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	anstream@0.6.14
	anstyle-parse@0.2.4
	anstyle-query@1.0.3
	anstyle-wincon@3.0.3
	anstyle@1.0.7
	autocfg@1.2.0
	backtrace@0.3.71
	bit-set@0.5.3
	bit-vec@0.6.3
	bumpalo@3.16.0
	bytes@1.6.0
	cc@1.0.96
	cfg-if@1.0.0
	chrono@0.4.38
	clap@4.5.4
	clap_builder@4.5.2
	clap_derive@4.5.4
	clap_lex@0.7.0
	colorchoice@1.0.1
	core-foundation-sys@0.8.6
	env_filter@0.1.0
	env_logger@0.11.3
	equivalent@1.0.1
	fancy-regex@0.13.0
	futures-core@0.3.30
	futures-task@0.3.30
	futures-util@0.3.30
	gimli@0.28.1
	hashbrown@0.14.5
	heck@0.5.0
	hermit-abi@0.3.9
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.60
	indexmap@2.2.6
	is_terminal_polyfill@1.70.0
	js-sys@0.3.69
	libc@0.2.154
	log@0.4.21
	memchr@2.7.2
	miniz_oxide@0.7.2
	mio@0.8.11
	num-traits@0.2.18
	num_cpus@1.16.0
	object@0.32.2
	once_cell@1.19.0
	pin-project-lite@0.2.14
	pin-utils@0.1.0
	proc-macro-crate@3.1.0
	proc-macro2@1.0.81
	quick-xml@0.31.0
	quote@1.0.36
	regex-automata@0.4.6
	regex-syntax@0.8.3
	regex@1.10.4
	rustc-demangle@0.1.23
	socket2@0.5.7
	strsim@0.11.1
	syn@2.0.60
	thiserror-impl@1.0.59
	thiserror@1.0.59
	tokio-macros@2.2.0
	tokio-pipe@0.2.12
	tokio@1.37.0
	toml_datetime@0.6.5
	toml_edit@0.21.1
	unicode-ident@1.0.12
	utf8parse@0.2.1
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.92
	wasm-bindgen-macro-support@0.2.92
	wasm-bindgen-macro@0.2.92
	wasm-bindgen-shared@0.2.92
	wasm-bindgen@0.2.92
	wayrs-client@1.1.0
	wayrs-core@1.0.0
	wayrs-proto-parser@2.0.0
	wayrs-protocols@0.14.0
	wayrs-scanner@0.14.0
	windows-core@0.52.0
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
"

inherit cargo

DESCRIPTION="Keep Wayland clipboard even after programs close"
HOMEPAGE="https://github.com/Linus789/wl-clip-persist"

SRC_URI="
	${CARGO_CRATE_URIS}
	https://github.com/Linus789/wl-clip-persist/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+=" Unicode-DFS-2016"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/wayland-protocols
	dev-libs/wayland
"
RDEPEND="${DEPEND}"

# Rust package
QA_FLAGS_IGNORED="usr/bin/${PN}"
