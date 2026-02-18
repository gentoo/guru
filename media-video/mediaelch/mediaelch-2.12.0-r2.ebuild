# Copyright 2021-2026 Gentoo Authors
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
IUSE="debug lto"

DEPEND="dev-libs/quazip
	dev-qt/qt5compat:6
	dev-qt/qtbase:6[concurrent,gui,opengl,sql,widgets,xml]
	dev-qt/qtdeclarative:6
	dev-qt/qtmultimedia:6
	dev-qt/qtsvg:6
	dev-qt/qttools:6
	media-video/ffmpeg
	media-video/mediainfo
	x11-libs/libxkbcommon"

RDEPEND="$DEPEND"

PATCHES="${FILESDIR}/2.12.0-1878.patch"

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
	mycmakeargs+=("-DMEDIAELCH_FORCE_QT6=ON")

	use lto && mycmakeargs+=("-DENABLE_LTO=ON")

	cmake_src_configure
}
