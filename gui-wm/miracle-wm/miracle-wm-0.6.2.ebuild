# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_13 )

inherit cmake python-single-r1

DESCRIPTION="Tiling Wayland compositor based on Mir"
HOMEPAGE="https://github.com/miracle-wm-org/miracle-wm"
SRC_URI="https://github.com/miracle-wm-org/miracle-wm/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+ MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="systemd test"
REQUIRED_USE="systemd? ( ${PYTHON_REQUIRED_USE} )"
RESTRICT="!test? ( test )"

COMMON_DEPEND="
	dev-cpp/yaml-cpp:=
	dev-cpp/nlohmann_json
	dev-libs/glib:2
	dev-libs/json-c:=
	dev-libs/libevdev
	dev-libs/libpcre2:=
	dev-libs/wayland
	>=gui-libs/mir-2.18:=
	media-libs/libglvnd
	x11-base/xwayland
"
RDEPEND="
	${COMMON_DEPEND}
	systemd? (
		${PYTHON_DEPS}
		$(python_gen_cond_dep '
			dev-python/dbus-next[${PYTHON_USEDEP}]
			dev-python/tenacity[${PYTHON_USEDEP}]
		')
	)
"
DEPEND="
	${COMMON_DEPEND}
	media-libs/glm
"
BDEPEND="
	virtual/pkgconfig
	test? ( dev-cpp/gtest )
"

PATCHES=(
	"${FILESDIR}/${PN}-0.6.1-conditional-tests.patch"
)

pkg_setup() {
	use systemd && python-single-r1_pkg_setup
}

src_prepare() {
	cmake_src_prepare
	use test || cmake_comment_add_subdirectory tests/
	use systemd && python_fix_shebang session/usr/bin/libexec/miracle-wm-wait-sni-ready
}

src_configure() {
	local mycmakeargs=(
		-DSYSTEMD_INTEGRATION=$(usex systemd)
		-DWITH_TESTS=$(usex test)
	)
	cmake_src_configure
}

src_test() {
	"${BUILD_DIR}/tests/miracle-wm-tests" || die
	"${BUILD_DIR}/miracle-wm-config/test_miracle_wm_config_c_api" || die
}
