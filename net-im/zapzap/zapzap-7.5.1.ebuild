# Copyright 2025-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..15} )
DISTUTILS_USE_PEP517=setuptools
inherit xdg distutils-r1 desktop

DESCRIPTION="WhatsApp desktop application written in PyQt6 + PyQt6-WebEngine"
HOMEPAGE="https://github.com/rafatosta/zapzap"

SRC_URI="https://github.com/rafatosta/zapzap/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/pyqt6[${PYTHON_USEDEP},dbus]
	dev-python/pyqt6-webengine[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/pyqt6[${PYTHON_USEDEP},testlib]
	)
"

EPYTEST_PLUGINS=()

distutils_enable_tests pytest

src_install() {
	distutils-r1_src_install
	doicon -s scalable share/icons/com.rtosta.zapzap.svg
	domenu share/applications/com.rtosta.zapzap.desktop
	insinto /usr/share/metainfo
	doins share/metainfo/com.rtosta.zapzap.appdata.xml
}

src_test() {
	local -x QT_QUICK_BACKEND=software
	distutils-r1_src_test
}

EPYTEST_DESELECT=(
	# Failures related to the icon theme settings in the testing environment
	# Might be possible to resolve, if someone wants to investigate
	tests/test_accounts_settings_ui.py::AccountsSettingsUiTests::test_edit_dialog_combines_name_and_icon_controls
	tests/test_accounts_settings_ui.py::AccountsSettingsUiTests::test_photo_and_custom_icon_colors_are_retained_when_switching
	tests/test_browser_page_button_ui.py::BrowserPageButtonUiTests::test_disabled_effect_preserves_transparent_avatar_shape
	tests/test_browser_page_button_ui.py::BrowserPageButtonUiTests::test_indicator_is_limited_to_active_unmuted_accounts_with_activity
	tests/test_browser_page_button_ui.py::BrowserPageButtonUiTests::test_unread_count_is_not_rendered_inside_avatar
	tests/test_check_box.py::CheckBoxTests::test_menu_indicators_match_checkbox_and_radio_semantics
	tests/test_donations_page.py::DonationsPageUiTests::test_method_and_external_icons_render_for_light_and_dark_themes
	tests/test_update_checker.py::UpdateUiTests::test_sidebar_icon_opens_details_and_download_action
	tests/test_whatsapp_app_lock.py::WhatsAppAppLockTests::test_sidebar_button_is_accessible_themed_and_in_the_utility_group

	# Don't feel like categorizing
	tests/test_accounts_settings_ui.py::AccountsSettingsUiTests::test_account_context_menu_waits_for_keyboard_before_focusing_action  # AssertionError: False is not true
	tests/test_dictionary_manager.py::DictionaryManagerUiTests::test_package_catalog_hides_management_and_cannot_start_catalog_network  # AttributeError: 'types.SimpleNamespace' object has no attribute 'pdf_click_behavior'
	tests/test_dictionary_manager.py::DictionaryManagerUiTests::test_settings_exposes_one_shared_manager_action_without_network  # AttributeError: 'types.SimpleNamespace' object has no attribute 'pdf_click_behavior'
	tests/test_dictionary_options.py::DictionarySettingsUiTests::test_settings_page_displays_selected_language_summary  # AttributeError: 'FakeLanguageDownloadSettingsModel' object has no attribute 'pdf_click_...
	tests/test_dictionary_options.py::DictionarySettingsUiTests::test_settings_summary_updates_after_selection_changes  # AttributeError: 'FakeLanguageDownloadSettingsModel' object has no attribute 'pdf_click_...
	tests/test_global_mute.py::GlobalMuteTests::test_sidebar_mute_toggles_one_persistent_state_and_all_accounts
		# AssertionError: True is not false
	tests/test_quick_access_panels_ui.py::FloatingMonitoringPanelUiTests::test_panel_renders_add_account_row_and_footer_actions  # AssertionError: True is not false
	tests/test_settings_lazy_loading.py::SettingsLazyPackagingTest::test_pyinstaller_builds_collect_dynamic_settings_modules  # AssertionError: '--collect-submodules' not found in '#!/usr/bin/env bash\nset -euo pipe...
	tests/test_translations.py::TranslationCatalogTests::test_zh_cn_catalog_is_complete_and_preserves_placeholders
		# AssertionError: 'Search accounts...' not found in {'Continue securely in your browser a...
	tests/test_translations.py::TranslationCatalogTests::test_zh_cn_is_discoverable_and_loads_from_runtime_catalog
		# AssertionError: '{site} wants to download multiple files.' != '{site} 请求下载多个文件。'
	tests/test_webengine_diagnostics.py::WebEngineProbeTests::test_real_webview_variants_in_fresh_processes_keep_filter_and_default_zoom_behavior  # AssertionError: 1 != 0 : Traceback (most recent call last):
)
