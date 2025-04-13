# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit virtualx xdg cmake git-r3

DESCRIPTION="Share a mouse and keyboard between computers (fork of Barrier)"
HOMEPAGE="https://github.com/input-leap/input-leap"
EGIT_REPO_URI="https://github.com/input-leap/input-leap.git"

LICENSE="GPL-2"
SLOT="0"
IUSE="gui test wayland"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-libs/openssl:0=
	net-misc/curl
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXi
	x11-libs/libXinerama
	x11-libs/libXrandr
	x11-libs/libXtst
	gui? (
		dev-qt/qtbase:6[gui,network,widgets]
		net-dns/avahi[mdnsresponder-compat]
	)
	wayland? (
		dev-libs/glib:2
		>=dev-libs/libei-0.99.1
		dev-libs/libportal:=
		x11-libs/libxkbcommon
	)
"
DEPEND="
	${RDEPEND}
	x11-base/xorg-proto
"
BDEPEND="
	virtual/pkgconfig
	gui? ( dev-qt/qttools:6[linguist] )
	test? ( dev-cpp/gtest )
"

DOCS=(
	ChangeLog
	README.md
	doc/${PN}.conf.example{,-advanced,-basic}
)

src_prepare() {
	# respect CXXFLAGS
	sed -i '/CMAKE_POSITION_INDEPENDENT_CODE/d' CMakeLists.txt || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DINPUTLEAP_BUILD_GUI=$(usex gui)
		-DINPUTLEAP_BUILD_TESTS=$(usex test)
		-DINPUTLEAP_USE_EXTERNAL_GTEST=ON
		-DINPUTLEAP_BUILD_X11=ON
		-DINPUTLEAP_BUILD_LIBEI=$(usex wayland)
	)
	cmake_src_configure
}

src_test() {
	"${BUILD_DIR}"/bin/unittests || die
	virtx "${BUILD_DIR}"/bin/integtests || die
}
