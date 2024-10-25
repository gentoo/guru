# Copyright 2021-223 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Video metadata scraper"
HOMEPAGE="https://www.mediaelch.de/"

MY_PN=MediaElch

if [[ ${PV} == *9999 ]] ; then
	EGIT_REPO_URI="https://github.com/Komet/$MY_PN"
	EGIT_BRANCH="master"
	EGIT_SUBMODULES=()
	inherit git-r3
	S="${WORKDIR}/${PN}-9999"
else
	RESTRICT="mirror"
	SRC_URI="https://github.com/Komet/$MY_PN/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S=$WORKDIR/${MY_PN}-${PV}
fi

LICENSE="LGPL-3"
SLOT="0"
IUSE="debug qt5 +qt6 lto"
REQUIRED_USE="|| ( qt5 qt6 )"

DEPEND=">dev-libs/quazip-1.3[qt5?,qt6]
	qt5? (
		dev-qt/qtconcurrent:5
		dev-qt/qtcore:5
		dev-qt/qtdeclarative:5
		dev-qt/qtgui:5
		dev-qt/qtmultimedia:5[widgets]
		dev-qt/qtopengl:5
		dev-qt/qtsql:5
		dev-qt/qtsvg:5
		dev-qt/qtxmlpatterns:5
	)
	qt6? (
		dev-qt/qt5compat:6
		dev-qt/qtbase:6[concurrent,gui,opengl,sql,widgets,xml]
		dev-qt/qtdeclarative:6
		dev-qt/qtmultimedia:6
		dev-qt/qtsvg:6
		dev-qt/qttools:6
	)
	media-video/ffmpeg
	media-video/mediainfo
	x11-libs/libxkbcommon"

RDEPEND="$DEPEND"

src_configure() {
	local mycmakeargs=(
		"-DUSE_EXTERN_QUAZIP=ON"
		"-DDISABLE_UPDATER=ON"
	)

	if use debug; then
		CMAKE_BUILD_TYPE=Debug
		mycmakeargs+=("-DSANITIZE_ADDRESS=on")
		CXXFLAGS+=("-fsanitize=address")
	fi

	mycmakeargs+=("-DCMAKE_C_FLAGS=${CFLAGS}")
	mycmakeargs+=("-DCMAKE_CXX_FLAGS=${CXXFLAGS}")

	use qt5 && mycmakeargs+=("-DMEDIAELCH_FORCE_QT5=ON")
	use qt6 && mycmakeargs+=("-DMEDIAELCH_FORCE_QT6=ON")

	use lto && mycmakeargs+=("-DENABLE_LTO=ON")

	cmake_src_configure
}
