# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Tiling Wayland compositor based on Mir"
HOMEPAGE="https://github.com/miracle-wm-org/miracle-wm"
SRC_URI="https://github.com/miracle-wm-org/miracle-wm/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+ MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="systemd test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-cpp/yaml-cpp:=
	dev-cpp/nlohmann_json
	dev-libs/glib:2
	dev-libs/json-c:=
	dev-libs/libevdev
	dev-libs/libpcre2:=
	>=gui-libs/mir-2.18:=
	media-libs/libglvnd
	x11-base/xwayland
"
DEPEND="
	${RDEPEND}
	media-libs/glm
"
BDEPEND="
	virtual/pkgconfig
	test? ( dev-cpp/gtest )
"

src_prepare() {
	cmake_src_prepare
	use test || cmake_comment_add_subdirectory tests/
}

src_configure() {
	local mycmakeargs=(
		-DSYSTEMD_INTEGRATION=$(usex systemd)
	)
	cmake_src_configure
}

src_test() {
	"${BUILD_DIR}/bin/miracle-wm-tests" || die
}
