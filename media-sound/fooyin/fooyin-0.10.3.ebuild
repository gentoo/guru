# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="A customizable music player, Qt clone of foobar2000"
HOMEPAGE="https://www.fooyin.org/"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/fooyin/fooyin.git"
else
	SRC_URI="
		https://github.com/fooyin/fooyin/archive/refs/tags/v${PV}.tar.gz
			-> ${P}.tar.gz
	"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

IUSE="alsa +archive gme openmpt +pipewire +replaygain sdl sndfile soundtouch soxr test"
RESTRICT="!test? ( test )"
REQUIRED_USE="
	|| ( alsa pipewire sdl )
"

RDEPEND="
	dev-libs/icu:=
	dev-libs/kdsingleapplication
	dev-libs/qcoro[network]
	dev-qt/qtbase:6[concurrent,dbus,gui,network,sql,widgets]
	dev-qt/qtimageformats:6
	dev-qt/qtsvg:6
	media-libs/taglib:=
	media-video/ffmpeg:=
	alsa? ( media-libs/alsa-lib )
	archive? ( app-arch/libarchive:= )
	gme? ( media-libs/game-music-emu )
	openmpt? ( media-libs/libopenmpt )
	pipewire? ( media-video/pipewire:= )
	replaygain? ( media-libs/libebur128:= )
	sdl? ( media-libs/libsdl2 )
	sndfile? ( media-libs/libsndfile )
	soundtouch? ( media-libs/libsoundtouch:= )
	soxr? ( media-libs/soxr )
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-qt/qttools:6[linguist]
	test? ( dev-cpp/gtest )
"

src_prepare() {
	sed -i CMakeLists.txt \
		-e "s|/doc/${PN}|/doc/${PF}|g" \
		-e '/option(BUILD_TESTING/aenable_testing()' \
		|| die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_ALSA=$(usex alsa)
		-DBUILD_TESTING=$(usex test)
		-DBUILD_CCACHE=OFF
		-DINSTALL_HEADERS=ON
		$(cmake_use_find_package archive LibArchive)
		$(cmake_use_find_package gme LIBGME)
		$(cmake_use_find_package openmpt OpenMpt)
		$(cmake_use_find_package pipewire PipeWire)
		$(cmake_use_find_package replaygain Ebur128)
		$(cmake_use_find_package sdl SDL2)
		$(cmake_use_find_package sndfile SndFile)
		$(cmake_use_find_package soundtouch SoundTouch)
		$(cmake_use_find_package soxr SoXR)
	)

	cmake_src_configure
}
