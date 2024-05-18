# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{7..12} )
inherit git-r3 python-r1 xdg cmake
EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"
# this URL is to make the tests compile since organicmaps usually dynamically clones the repo
# maybe a better way would be to skip the test
EGIT_WORLD_FEED_REPO_URI="https://github.com/${PN}/world_feed_integration_tests_data.git"
# organicmaps gets more and more system libraries, we use as many
# as currently possible, use submodules for the rest
EGIT_SUBMODULES=(
	3party/harfbuzz/harfbuzz
	3party/fast_double_parser
	3party/just_gtfs
	3party/protobuf/protobuf # wait for https://github.com/organicmaps/organicmaps/pull/6310
	3party/fast_obj
)

DESCRIPTION="Offline maps and navigation using OpenStreetMap data"
HOMEPAGE="https://organicmaps.app"

LICENSE="Apache-2.0"
SLOT="0"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

# depend on sys-libs/zlib[minizip] when it is not pulled in as subproject anymore
RDEPEND="
	dev-cpp/gflags
	dev-db/sqlite
	dev-lang/python
	dev-libs/boost
	dev-libs/icu
	dev-libs/jansson
	dev-libs/utfcpp
	dev-qt/qtpositioning:6
	dev-qt/qtsvg:6
	dev-util/vulkan-headers
	media-libs/freetype
	sys-libs/zlib
	${PYTHON_DEPS}
"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}"/more-3party.patch "${FILESDIR}"/no-dynamic-download.patch )

WORLD_FEED_TESTS_S="${WORKDIR}/world_feed_integration_tests_data-${PV}"

src_unpack () {
	git-r3_fetch
	git-r3_checkout
	git-r3_fetch "${EGIT_WORLD_FEED_REPO_URI}"
	git-r3_checkout "${EGIT_WORLD_FEED_REPO_URI}" "${WORLD_FEED_TESTS_S}"
}

src_configure() {
	# organicmaps wants a ./configure.sh execution.
	# However, this setups mainly stuff for Android and XCode builds that we don't need.
	# We need just this line here
	cp private_default.h private.h || die

	CMAKE_BUILD_TYPE="RelWithDebInfo"
	local mycmakeargs=(
		-DWITH_SYSTEM_PROVIDED_3PARTY=yes
		-DBUILD_SHARED_LIBS=off
		-DTEST_DATA_REPO_URL="${WORLD_FEED_TESTS_S}"
	)
	cmake_src_configure
}

pkg_postinst() {
	xdg_icon_cache_update

	einfo "For dark  mode type in search ?dark"
	einfo "For light mode type in search ?light"
}
