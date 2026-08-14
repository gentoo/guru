# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=no
DISTUTILS_SINGLE_IMPL=1
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 gnome2-utils meson optfeature xdg

DESCRIPTION="Run Windows software and games on Linux"
HOMEPAGE="
	https://usebottles.com
	https://github.com/bottlesdevs/Bottles
"
SRC_URI="https://github.com/bottlesdevs/Bottles/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/Bottles-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/glib:2
	dev-libs/libportal
	gui-libs/gtk:4
	gui-libs/gtksourceview:5
	gui-libs/libadwaita:1

	dev-vcs/fvs2

	$(python_gen_cond_dep '
		app-arch/patool[${PYTHON_USEDEP}]
		dev-python/certifi[${PYTHON_USEDEP}]
		dev-python/chardet[${PYTHON_USEDEP}]
		dev-python/charset-normalizer[${PYTHON_USEDEP}]
		dev-python/icoextract[${PYTHON_USEDEP}]
		dev-python/idna[${PYTHON_USEDEP}]
		dev-python/markdown[${PYTHON_USEDEP}]
		dev-python/orjson[${PYTHON_USEDEP}]
		dev-python/pathvalidate[${PYTHON_USEDEP}]
		dev-python/pefile[${PYTHON_USEDEP}]
		dev-python/pycairo[${PYTHON_USEDEP}]
		dev-python/pycurl[${PYTHON_USEDEP}]
		dev-python/pygobject[${PYTHON_USEDEP}]
		dev-python/pyxdg[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/urllib3[${PYTHON_USEDEP}]
		dev-python/wheel[${PYTHON_USEDEP}]
		dev-python/yara-python[${PYTHON_USEDEP}]
		media-gfx/vkbasalt-cli[${PYTHON_USEDEP}]
	')
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-libs/appstream-glib
	dev-libs/glib:2
	dev-util/blueprint-compiler
	dev-util/desktop-file-utils
	dev-util/gtk-update-icon-cache
	sys-devel/gettext

	test? (
		$(python_gen_cond_dep '
			dev-python/freezegun[${PYTHON_USEDEP}]
		')
	)
"

PATCHES=(
	"${FILESDIR}/${PN}-64.1-dont-stub-gi.repository.patch"
	"${FILESDIR}/${PN}-64.1-relax-AppStream-file-validation.patch"
	"${FILESDIR}/${PN}-64.1-remove-Flatpak-related-checks.patch"
)

EPYTEST_DESELECT=(
	bottles/tests/backend/integration/playtime/test_disabled_tracking.py::test_disabled_tracking_smoke
	bottles/tests/backend/integration/playtime/test_wine_executor_playtime.py::test_wine_executor_emits_and_updates_totals
	bottles/tests/backend/manager/test_manager.py::test_manager_cli_skips_connection_check
	bottles/tests/backend/manager/test_playtime.py::test_disable_tracking_method
	bottles/tests/backend/manager/test_playtime.py::test_disabled_tracker_is_noop
	bottles/tests/backend/wine/test_executor.py::test_run_program_substitutes_placeholders
)

EPYTEST_PLUGINS=( pytest-mock )
distutils_enable_tests pytest

src_test() {
	meson_src_test
	distutils-r1_src_test
}

src_install() {
	meson_src_install

	python_fix_shebang "${ED}/usr/bin"
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update

	optfeature "extracting files from .cab files" app-arch/cabextract
	optfeature "7-Zip archiver support" app-arch/p7zip
	optfeature "Vulkan support" dev-util/vulkan-tools
	optfeature "icon/image convertion" media-gfx/imagemagick
	optfeature "display information support" x11-apps/xdpyinfo

	optfeature "preloading game files into memory" dev-util/vmtouch
	optfeature "optimizing Linux system performance on demand" games-util/gamemode
	optfeature "an efficient micro-compositor for running games" gui-wm/gamescope
	optfeature "monitoring FPS, temperatures, CPU/GPU load and more" games-util/mangohud
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
