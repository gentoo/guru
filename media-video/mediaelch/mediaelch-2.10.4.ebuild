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
IUSE="debug"

DEPEND="dev-libs/quazip
	dev-qt/qtconcurrent:5
	dev-qt/qtmultimedia:5[widgets]
	dev-qt/qtsql:5
	dev-qt/qtsvg:5
	dev-qt/qtxmlpatterns:5
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-util/cmake
	media-video/mediainfo
	media-libs/libzen
	media-libs/phonon"

src_configure() {
	local mycmakeargs=("-DUSE_EXTERN_QUAZIP=ON")
	if use debug; then
		CMAKE_BUILD_TYPE=Debug
		mycmakeargs+=("-DSANITIZE_ADDRESS=on")
		CXXFLAGS+=("-fsanitize=address")
	fi

	cmake_src_configure
}
