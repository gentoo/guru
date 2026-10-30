# Copyright 2020-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	adler2@2.0.1
	aho-corasick@1.1.5
	anstream@1.0.0
	anstyle-parse@1.0.0
	anstyle-query@1.1.5
	anstyle-wincon@3.0.11
	anstyle@1.0.14
	anyhow@1.0.104
	assert_cmd@2.2.2
	autocfg@1.5.1
	base64@0.23.1
	base64ct@1.8.3
	bitflags@1.3.2
	bitflags@2.13.2
	bstr@1.13.1
	bumpalo@3.20.3
	bytes@1.12.1
	cc@1.10.0
	cfg-if@1.0.5
	cfg_aliases@0.2.2
	clap@4.6.7
	clap_builder@4.6.7
	clap_derive@4.6.7
	clap_lex@1.1.1
	colorchoice@1.0.5
	combine@4.6.9
	core-foundation-sys@0.8.7
	core-foundation@0.10.1
	crc32fast@1.5.3
	defmt-macros@1.2.0
	defmt-parser@1.1.0
	defmt@1.2.0
	der@0.8.2
	difflib@0.4.0
	env_filter@2.0.0
	env_logger@0.11.11
	equivalent@1.0.3
	errno-dragonfly@0.1.2
	errno@0.2.8
	errno@0.3.14
	escargot@0.5.15
	etcetera@0.11.0
	fastrand@2.5.0
	filetime@0.2.29
	find-msvc-tools@0.1.15
	flate2@1.1.10
	float-cmp@0.10.0
	foreign-types-shared@0.1.1
	foreign-types@0.3.2
	getrandom@0.2.17
	getrandom@0.4.3
	hashbrown@0.17.1
	heck@0.5.0
	http@1.5.0
	httparse@1.10.1
	indexmap@2.14.2
	is_terminal_polyfill@1.70.2
	itoa@1.0.18
	jiff-core@0.1.1
	jiff-static@0.2.38
	jiff@0.2.38
	jni-macros@0.22.4
	jni-sys-macros@0.4.1
	jni-sys@0.4.1
	jni@0.22.4
	js-sys@0.3.106
	libc@0.2.191
	linux-raw-sys@0.12.1
	log@0.4.34
	memchr@2.8.3
	miniz_oxide@0.9.1
	native-tls@0.2.18
	nix@0.31.3
	normalize-line-endings@0.3.0
	num-traits@0.2.19
	once_cell@1.21.4
	once_cell_polyfill@1.70.2
	openssl-macros@0.1.1
	openssl-probe@0.2.1
	openssl-sys@0.9.117
	openssl@0.10.81
	pager@0.16.1
	pem-rfc7468@1.0.0
	percent-encoding@2.3.2
	pkg-config@0.3.34
	portable-atomic-util@0.2.8
	portable-atomic@1.15.0
	predicates-core@1.0.10
	predicates-tree@1.0.13
	predicates@3.1.4
	proc-macro2@1.0.107
	quote@1.0.47
	r-efi@6.0.0
	regex-automata@0.4.18
	regex-syntax@0.8.11
	regex@1.13.1
	ring@0.17.14
	rustc_version@0.4.1
	rustix@1.1.5
	rustls-native-certs@0.8.5
	rustls-pki-types@1.15.1
	rustls-platform-verifier-android@0.2.0
	rustls-platform-verifier@0.7.1
	rustls-webpki@0.103.16
	rustls@0.23.46
	rustversion@1.0.23
	same-file@1.0.6
	schannel@0.1.30
	security-framework-sys@2.17.0
	security-framework@3.7.0
	semver@1.0.28
	serde@1.0.229
	serde_core@1.0.229
	serde_derive@1.0.229
	serde_json@1.0.154
	serde_spanned@1.1.2
	shlex@2.0.1
	simd-adler32@0.3.10
	simd_cesu8@1.2.0
	simdutf8@0.1.5
	subtle@2.6.1
	syn@2.0.119
	syn@3.0.9
	tempfile@3.27.0
	terminal_size@0.4.4
	termtree@0.5.1
	thiserror-impl@2.0.21
	thiserror@2.0.21
	toml@1.1.8+spec-1.1.0
	toml_datetime@1.1.2+spec-1.1.0
	toml_parser@1.1.5+spec-1.1.0
	toml_writer@1.1.3+spec-1.1.0
	typed-path@0.13.0
	unicode-ident@1.0.27
	untrusted@0.9.0
	ureq-proto@0.6.5
	ureq@3.5.0
	utf8-zero@0.8.1
	utf8parse@0.2.2
	vcpkg@0.2.15
	wait-timeout@0.2.1
	walkdir@2.5.0
	wasi@0.11.1+wasi-snapshot-preview1
	wasm-bindgen-macro-support@0.2.129
	wasm-bindgen-macro@0.2.129
	wasm-bindgen-shared@0.2.129
	wasm-bindgen@0.2.129
	webpki-root-certs@1.0.11
	webpki-roots@1.0.11
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.11
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-link@0.2.1
	windows-sys@0.52.0
	windows-sys@0.61.2
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.52.6
	winnow@1.0.4
	yansi@1.0.1
	zeroize@1.9.1
	zip@9.1.0
	zlib-rs@0.6.8
	zmij@1.0.23
	zopfli@0.8.4
"

RUST_MIN_VER="1.88.0"

inherit cargo flag-o-matic shell-completion

DESCRIPTION="A very fast implementation of tldr in Rust"
HOMEPAGE="https://github.com/tldr-pages/tldr
	https://github.com/tealdeer-rs/tealdeer"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/tealdeer-rs/tealdeer.git"
	src_unpack() {
		git-r3_src_unpack
		cargo_live_src_unpack
	}
else
	SRC_URI="https://github.com/tealdeer-rs/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	SRC_URI+=" ${CARGO_CRATE_URIS}"
	KEYWORDS="~amd64"
fi

LICENSE="Apache-2.0 ISC MIT MPL-2.0"
# Dependent crate licenses
LICENSE+=" Apache-2.0 BSD CDLA-Permissive-2.0 ISC MIT Unicode-3.0 ZLIB"
SLOT="0"

RDEPEND="!app-text/tldr"

QA_FLAGS_IGNORED="usr/bin/tldr"

RESTRICT="mirror"
# apply-crates-fixes start
DEPEND="
	dev-libs/openssl
"
# apply-crates-fixes end

src_configure() {
	filter-flags '-flto*' # ring crate fails compile with lto
	cargo_src_configure
}
# apply-crates-fixes start
src_compile(){
	export OPENSSL_NO_VENDOR=1 # fix for openssl-sys
	cargo_src_compile
}
# apply-crates-fixes end

src_test(){
	# network related tests that will indefinitely hang #{{{
	local CARGO_SKIP_TESTS=(
		'placeholder_format::cli'
		'placeholder_format::config'
		'placeholder_format::default_long'
		'test_autoupdate_cache'
		'test_cache_location_not_a_directory'
		'test_cache_location_permission_denied'
		'test_cache_location_source'
		'test_cannot_build_without_tls_feature'
		'test_clear_only_pages_directory'
		'test_common_platform_is_used_as_fallback'
		'test_config_platforms'
		'test_correct_rendering_v1'
		'test_correct_rendering_v2'
		'test_correct_rendering_with_config'
		'test_create_cache_directory_path'
		'test_custom_page_overwrites'
		'test_custom_pages_dir_is_not_dir'
		'test_custom_patch_appends_to_common'
		'test_custom_patch_does_not_append_to_custom'
		'test_edit_page'
		'test_edit_patch'
		'test_fail_on_custom_config_path_is_directory'
		'test_failure_on_unknown_field_in_config'
		'test_failure_on_unknown_field_in_override_config'
		'test_invalid_page_name'
		'test_list_broken_pipe'
		'test_list_flag_rendering'
		'test_load_the_correct_config'
		'test_lowercased_page_lookup'
		'test_macos_is_alias_for_osx'
		'test_markdown_rendering'
		'test_missing_cache'
		'test_multi_platform_list_flag_rendering'
		'test_multiple_platform_command_search'
		'test_multiple_platform_command_search_not_found'
		'test_no_auto_update_with_list'
		'test_os_specific_page'
		'test_pager_flag_enable'
		'test_quiet_cache'
		'test_quiet_failures'
		'test_quiet_missing_cache'
		'test_quiet_old_cache'
		'test_raw_render_file'
		'test_recreate_dir'
		'test_rendering_color_auto'
		'test_rendering_color_never'
		'test_rendering_i18n'
		'test_rendering_with_indentation'
		'test_search_language_precedence'
		'test_seed_config_with_non_utf8_path'
		'test_setup_seed_config'
		'test_show_paths'
		'test_show_title_config'
		'test_spaces_find_command'
		'test_tealdeer_page_works_without_cache'
		'test_update_cache_default_features'
		'test_update_cache_native_tls'
		'test_update_cache_rustls_webpki'
		'test_update_language_arg'
		'test_warn_cache_age_never'
		'test_warn_invalid_tls_backend'
	) # }}}
	cargo_src_test --no-fail-fast
}

src_install() {
	cargo_src_install
	einstalldocs

	newbashcomp completion/bash_tealdeer tldr

	newzshcomp completion/zsh_tealdeer _tldr

	newfishcomp completion/fish_tealdeer tldr.fish
}
