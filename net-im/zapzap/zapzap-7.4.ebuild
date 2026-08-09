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

distutils_enable_tests pytest

src_install() {
	distutils-r1_src_install
	doicon -s scalable share/icons/com.rtosta.zapzap.svg
	domenu share/applications/com.rtosta.zapzap.desktop
	insinto /usr/share/metainfo
	doins share/metainfo/com.rtosta.zapzap.appdata.xml
}

EPYTEST_DESELECT=(
	# Failing tests
	tests/test_account_data_removal.py::DisabledAccountWebViewTest::test_data_is_removed_for_an_account_disabled_since_startup  # "Aborted"

	# Failures related to the icon theme settings in the testing environment
	# Might be possible to resolve, if someone wants to investigate
	tests/test_accounts_settings_ui.py::AccountsSettingsUiTests::test_edit_dialog_combines_name_and_icon_controls
	tests/test_accounts_settings_ui.py::AccountsSettingsUiTests::test_photo_and_custom_icon_colors_are_retained_when_switching
	tests/test_browser_page_button_ui.py::BrowserPageButtonUiTests::test_disabled_effect_preserves_transparent_avatar_shape
	tests/test_browser_page_button_ui.py::BrowserPageButtonUiTests::test_indicator_is_limited_to_active_unmuted_accounts_with_activity
	tests/test_browser_page_button_ui.py::BrowserPageButtonUiTests::test_unread_count_is_not_rendered_inside_avatar
	tests/test_check_box.py::CheckBoxTests::test_menu_indicators_match_checkbox_and_radio_semantics
	tests/test_donations_page.py::DonationsPageUiTests::test_method_and_external_icons_render_for_light_and_dark_themes
)
