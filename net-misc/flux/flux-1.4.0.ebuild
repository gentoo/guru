# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	addr2line@0.25.1
	adler2@2.0.1
	aho-corasick@1.1.3
	anstream@0.6.20
	anstyle-parse@0.2.7
	anstyle-query@1.1.4
	anstyle-wincon@3.0.10
	anstyle@1.0.13
	anyhow@1.0.100
	assert_cmd@2.0.17
	backtrace@0.3.76
	base64@0.21.7
	bincode@1.3.3
	bitflags@1.3.2
	bitflags@2.9.4
	block-buffer@0.10.4
	bstr@1.12.0
	bumpalo@3.19.0
	bytes@1.10.1
	cc@1.2.39
	cfg-if@1.0.3
	clap@4.5.48
	clap_builder@4.5.48
	clap_derive@4.5.47
	clap_lex@0.7.5
	colorchoice@1.0.4
	colored@2.2.0
	console@0.15.11
	core-foundation-sys@0.8.7
	core-foundation@0.9.4
	cpufeatures@0.2.17
	crypto-common@0.1.6
	difflib@0.4.0
	digest@0.10.7
	displaydoc@0.2.5
	doc-comment@0.3.3
	encode_unicode@1.0.0
	encoding_rs@0.8.35
	env_filter@0.1.3
	env_logger@0.11.8
	equivalent@1.0.2
	find-msvc-tools@0.1.2
	fnv@1.0.7
	form_urlencoded@1.2.2
	futures-channel@0.3.31
	futures-core@0.3.31
	futures-io@0.3.31
	futures-macro@0.3.31
	futures-sink@0.3.31
	futures-task@0.3.31
	futures-util@0.3.31
	generic-array@0.14.7
	getrandom@0.2.16
	gimli@0.32.3
	h2@0.3.27
	hashbrown@0.16.0
	heck@0.5.0
	hex@0.4.3
	http-body@0.4.6
	http@0.2.12
	httparse@1.10.1
	httpdate@1.0.3
	hyper-rustls@0.24.2
	hyper@0.14.32
	icu_collections@2.0.0
	icu_locale_core@2.0.0
	icu_normalizer@2.0.0
	icu_normalizer_data@2.0.0
	icu_properties@2.0.1
	icu_properties_data@2.0.1
	icu_provider@2.0.0
	idna@1.1.0
	idna_adapter@1.2.1
	indexmap@2.11.4
	indicatif@0.17.11
	io-uring@0.7.10
	ipnet@2.11.0
	is_terminal_polyfill@1.70.1
	itoa@1.0.15
	jiff-static@0.2.15
	jiff@0.2.15
	js-sys@0.3.81
	lazy_static@1.5.0
	libc@0.2.176
	litemap@0.8.0
	log@0.4.28
	memchr@2.7.6
	mime@0.3.17
	miniz_oxide@0.8.9
	mio@1.0.4
	nix@0.27.1
	number_prefix@0.4.0
	object@0.37.3
	once_cell@1.21.3
	once_cell_polyfill@1.70.1
	percent-encoding@2.3.2
	pin-project-lite@0.2.16
	pin-utils@0.1.0
	portable-atomic-util@0.2.4
	portable-atomic@1.11.1
	potential_utf@0.1.3
	predicates-core@1.0.9
	predicates-tree@1.0.12
	predicates@3.1.3
	proc-macro2@1.0.101
	quote@1.0.41
	regex-automata@0.4.11
	regex-syntax@0.8.6
	regex@1.11.3
	reqwest@0.11.27
	ring@0.17.14
	rustc-demangle@0.1.26
	rustls-pemfile@1.0.4
	rustls-webpki@0.101.7
	rustls@0.21.12
	rustversion@1.0.22
	ryu@1.0.20
	sct@0.7.1
	serde@1.0.228
	serde_core@1.0.228
	serde_derive@1.0.228
	serde_json@1.0.145
	serde_urlencoded@0.7.1
	sha2@0.10.9
	shlex@1.3.0
	slab@0.4.11
	smallvec@1.15.1
	socket2@0.5.10
	socket2@0.6.0
	stable_deref_trait@1.2.0
	strsim@0.11.1
	syn@2.0.106
	sync_wrapper@0.1.2
	synstructure@0.13.2
	system-configuration-sys@0.5.0
	system-configuration@0.5.1
	termtree@0.5.1
	thiserror-impl@1.0.69
	thiserror@1.0.69
	tinystr@0.8.1
	tokio-macros@2.5.0
	tokio-rustls@0.24.1
	tokio-util@0.7.16
	tokio@1.47.1
	tower-service@0.3.3
	tracing-core@0.1.34
	tracing@0.1.41
	try-lock@0.2.5
	typenum@1.18.0
	unicode-ident@1.0.19
	unicode-width@0.2.2
	untrusted@0.9.0
	url@2.5.7
	utf8_iter@1.0.4
	utf8parse@0.2.2
	version_check@0.9.5
	wait-timeout@0.2.1
	want@0.3.1
	wasi@0.11.1+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.104
	wasm-bindgen-futures@0.4.54
	wasm-bindgen-macro-support@0.2.104
	wasm-bindgen-macro@0.2.104
	wasm-bindgen-shared@0.2.104
	wasm-bindgen@0.2.104
	wasm-streams@0.4.2
	web-sys@0.3.81
	web-time@1.1.0
	webpki-roots@0.25.4
	windows-link@0.2.0
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-sys@0.59.0
	windows-sys@0.60.2
	windows-targets@0.48.5
	windows-targets@0.52.6
	windows-targets@0.53.4
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_gnullvm@0.53.0
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.6
	windows_aarch64_msvc@0.53.0
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.6
	windows_i686_gnu@0.53.0
	windows_i686_gnullvm@0.52.6
	windows_i686_gnullvm@0.53.0
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.6
	windows_i686_msvc@0.53.0
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnu@0.53.0
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_gnullvm@0.53.0
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.6
	windows_x86_64_msvc@0.53.0
	winreg@0.50.0
	writeable@0.6.1
	yoke-derive@0.8.0
	yoke@0.8.0
	zerofrom-derive@0.1.6
	zerofrom@0.1.6
	zerotrie@0.2.2
	zerovec-derive@0.11.1
	zerovec@0.11.4
"

inherit cargo

DESCRIPTION="Blazing-fast async segmented file downloader"
HOMEPAGE="https://github.com/compiledkernel-idk/flux"
SRC_URI="
	https://github.com/compiledkernel-idk/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+=" Apache-2.0 BSD ISC MIT Unicode-DFS-2016"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND=">=virtual/rust-1.70"

QA_FLAGS_IGNORED="usr/bin/${PN}"

src_install() {
	cargo_src_install

	dodoc README.md
	doman "${FILESDIR}"/${PN}.1 || true
}

pkg_postinst() {
	elog "flux has been installed successfully!"
	elog ""
	elog "Usage examples:"
	elog "  flux https://example.com/file.iso"
	elog "  flux --resume --sha256 <hash> <url>"
	elog ""
	elog "For more information, see: flux --help"
	elog "or visit: ${HOMEPAGE}"
}
