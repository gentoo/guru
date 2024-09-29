# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit virtualx xdg cmake git-r3

DESCRIPTION="Share a mouse and keyboard between computers (fork of Barrier)"
HOMEPAGE="https://github.com/input-leap/input-leap"
EGIT_REPO_URI="https://github.com/input-leap/input-leap.git"

LICENSE="GPL-2"
SLOT="0"
IUSE="gui test"
RESTRICT="!test? ( test )"

RDEPEND="
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
	dev-libs/openssl:0=
"
DEPEND="
	${RDEPEND}
	dev-cpp/gtest
	dev-cpp/gulrak-filesystem
	x11-base/xorg-proto
"
BDEPEND="
	virtual/pkgconfig
	gui? ( dev-qt/qttools:6[linguist] )
"

DOCS=(
	ChangeLog
	README.md
	doc/${PN}.conf.example{,-advanced,-basic}
)

src_configure() {
	local mycmakeargs=(
		-DINPUTLEAP_BUILD_GUI=$(usex gui)
		-DINPUTLEAP_BUILD_TESTS=$(usex test)
		-DINPUTLEAP_USE_EXTERNAL_GTEST=ON
	)

	cmake_src_configure
}

src_test() {
	"${BUILD_DIR}"/bin/unittests || die
	virtx "${BUILD_DIR}"/bin/integtests || die
}
