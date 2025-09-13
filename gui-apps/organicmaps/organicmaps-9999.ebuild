# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
inherit git-r3 python-any-r1 xdg cmake
EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"

EGIT_WORLD_FEED_REPO_URI="https://github.com/${PN}/world_feed_integration_tests_data.git"

# organicmaps gets more and more system libraries, we use as many
# as currently possible, use submodules for the rest
EGIT_SUBMODULES=(
	3party/fast_double_parser
	3party/fast_obj
	3party/glaze
	3party/glfw
	3party/harfbuzz/harfbuzz
	3party/imgui/imgui
	3party/just_gtfs
	3party/protobuf/protobuf # wait for https://github.com/organicmaps/organicmaps/pull/6310
)

DESCRIPTION="Offline maps and navigation using OpenStreetMap data"
HOMEPAGE="https://organicmaps.app"

LICENSE="Apache-2.0"

SLOT="0"

IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="
	dev-util/vulkan-headers
	${PYTHON_DEPS}
	test? ( dev-cpp/gtest )
"

# depend on sys-libs/zlib[minizip] when it is not pulled in as subproject anymore
RDEPEND="
	dev-cpp/fast_double_parser
	dev-cpp/gflags
	dev-db/sqlite
	dev-libs/boost
	dev-libs/icu
	dev-libs/jansson
	dev-libs/utfcpp
	dev-qt/qtbase:6[gui,network,opengl,widgets]
	dev-qt/qtpositioning:6
	dev-qt/qtsvg:6
	media-libs/freetype
	sys-libs/zlib
"

PATCHES=( "${FILESDIR}"/fix-jansson.patch "${FILESDIR}"/protobuf.patch "${FILESDIR}"/respect-ldflags.patch )

WORLD_FEED_TESTS_S="${WORKDIR}/world_feed_integration_tests_data-${PV}"

src_unpack () {
	git-r3_fetch
	git-r3_checkout

	if use test; then
		git-r3_fetch "${EGIT_WORLD_FEED_REPO_URI}"
		git-r3_checkout "${EGIT_WORLD_FEED_REPO_URI}" "${WORLD_FEED_TESTS_S}"
	fi
}

src_configure() {
	local mycmakeargs=(
		-DWITH_SYSTEM_PROVIDED_3PARTY=yes
		-DBUILD_SHARED_LIBS=off
		-DTEST_DATA_REPO_URL="$(usex test "${WORLD_FEED_TESTS_S}" "")"
		-DBUILD_TESTING=$(usex test ON OFF)
		-DCMAKE_BUILD_TYPE=Release
		-DSKIP_TESTS=1
	)
	cmake_src_configure
}

src_compile() {
	CMAKE_BUILD_TARGET="desktop"
	cmake_src_compile desktop
}

src_test() {
	cmake_src_test
}

src_install() {
	cmake_src_install

	rm -rf "${ED}"/usr/share/${PN}/data/world_feed_integration_tests_data || die
}

pkg_postinst() {
	xdg_pkg_postinst

	einfo "For dark  mode type in search ?dark"
	einfo "For light mode type in search ?light"
}
