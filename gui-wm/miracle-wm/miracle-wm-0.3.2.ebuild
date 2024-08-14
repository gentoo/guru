# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Tiling Wayland compositor based on Mir"
HOMEPAGE="https://github.com/mattkae/miracle-wm"
SRC_URI="https://github.com/mattkae/miracle-wm/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-cpp/yaml-cpp:=
	dev-cpp/nlohmann_json
	dev-libs/glib:2
	dev-libs/libevdev
	gui-libs/mir
	dev-libs/libpcre2:=
	media-libs/libglvnd
	x11-base/xwayland
	x11-libs/libnotify
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

src_test() {
	"${BUILD_DIR}/bin/miracle-wm-tests" || die
}
