# Copyright 2020-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
"

RUST_MIN_VER="1.88.0"

inherit cargo flag-o-matic shell-completion

DESCRIPTION="A very fast implementation of tldr in Rust"
HOMEPAGE="https://github.com/tldr-pages/tldr
	https://github.com/tealdeer-rs/tealdeer"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/tealdeer-rs/tealdeer.git"
else
	SRC_URI="https://github.com/tealdeer-rs/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	SRC_URI+=" ${CARGO_CRATE_URIS}"
	KEYWORDS="~amd64"
	RESTRICT="mirror"
fi

LICENSE="Apache-2.0 ISC MIT MPL-2.0"
# Dependent crate licenses
LICENSE+=" Apache-2.0 BSD CDLA-Permissive-2.0 ISC MIT Unicode-3.0 ZLIB"
SLOT="0"

RDEPEND="!app-text/tldr"

QA_FLAGS_IGNORED="usr/bin/tldr"

# apply-crates-fixes start
DEPEND="
	dev-libs/openssl
"
# apply-crates-fixes end

src_unpack() {
	if [[ "${PV}" == *9999* ]]; then
		git-r3_src_unpack
		cargo_live_src_unpack
	else
		cargo_src_unpack
	fi
}

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
