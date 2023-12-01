EAPI=7

inherit git-r3 xdg cmake
EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"

DESCRIPTION="Offline maps and navigation using OpenStreetMap data"
HOMEPAGE="https://organicmaps.app"

LICENSE="Apache-2.0"
SLOT="0"

DEPEND="sys-devel/clang
	>=dev-util/cmake-3.18.1
	dev-util/ninja
	media-libs/freetype
	dev-libs/icu
	sys-libs/libstdc++-v3
	dev-qt/qtcore
	dev-qt/qtpositioning
	dev-qt/qtsvg
	dev-db/sqlite
	sys-libs/zlib[minizip]"
RDEPEND=""

PATCHES=(
	"${FILESDIR}/${P}-zlib-compile.patch"
)

src_prepare() {
	eapply_user

	cmake_src_prepare
}

src_configure() {
	CMAKE_BUILD_TYPE="RelWithDebInfo"

	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=False
		-DINSTALL_GTEST=off
	)

	echo | ./configure.sh

	cmake_src_configure
}

pkg_postinst() {
	xdg_icon_cache_update

	einfo "For dark  mode type in search ?dark"
	einfo "For light mode type in search ?light"
}
