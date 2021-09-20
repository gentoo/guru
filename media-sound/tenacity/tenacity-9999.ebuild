# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

WX_GTK_VER="3.0-gtk3"

inherit git-r3 cmake wxwidgets xdg

EGIT_REPO_URI="https://github.com/tenacityteam/tenacity.git"

DESCRIPTION="Audio editor for Linux"
HOMEPAGE="https://tenacityaudio.org/"
LICENSE="GPL-2"
SLOT="0"
IUSE="midi id3tag +mp3 mp2 +ogg +vorbis +flac sbsms soundtouch ffmpeg vamp +lv2 vst2"

DEPEND="
	dev-db/sqlite
	dev-libs/serd
	dev-libs/sord
	x11-libs/wxGTK:${WX_GTK_VER}
	media-libs/libsndfile
	media-libs/portaudio
	media-libs/soxr
	media-sound/lame
	sys-libs/zlib
	ffmpeg? ( media-video/ffmpeg )
	flac? ( media-libs/flac )
	id3tag? ( media-libs/libid3tag )
	lv2? (
		media-libs/lv2
		media-libs/lilv
		media-libs/suil
	)
	midi? (
		media-libs/portmidi
		media-libs/portsmf
	)
	mp2? ( media-sound/twolame )
	mp3? ( media-libs/libmad )
	ogg? ( media-libs/libogg )
	sbsms? ( media-libs/libsbsms )
	soundtouch? ( media-libs/libsoundtouch )
	vamp? ( media-libs/vamp-plugin-sdk )
	vorbis? ( media-libs/libvorbis )
	vst2? ( x11-libs/gtk+[X] )
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	sed -i 's/set( CMAKE_BUILD_WITH_INSTALL_RPATH FALSE )/set( CMAKE_BUILD_WITH_INSTALL_RPATH TRUE )/' "${S}/CMakeLists.txt" || die
	cmake_src_prepare
}

src_configure() {
	setup-wxwidgets
	local mycmakeargs=(
		"-DVCPKG=OFF"
		"-DMIDI=$(usex midi ON OFF)"
		"-DID3TAG=$(usex id3tag ON OFF)"
		"-DMP3_DECODING=$(usex mp3 ON OFF)"
		"-DMP2_ENCODING=$(usex mp2 ON OFF)"
		"-DOGG=$(usex ogg ON OFF)"
		"-DVORBIS=$(usex vorbis ON OFF)"
		"-DFLAC=$(usex flac ON OFF)"
		"-DSBSMS=$(usex sbsms ON OFF)"
		"-DSOUNDTOUCH=$(usex soundtouch ON OFF)"
		"-DFFMPEG=$(usex ffmpeg ON OFF)"
		"-DVAMP=$(usex vamp ON OFF)"
		"-DLV2=$(usex lv2 ON OFF)"
		"-DVST2=$(usex vst2 ON OFF)"
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	# TODO: Improve installation upstream
	rm "${ED}/usr/tenacity" || die
	mv "${ED}/usr/share/doc/${PN}" "${ED}/usr/share/doc/${PF}" || die
	mv "${BUILD_DIR}/lib-src/libnyquist/liblibnyquist.so" "${ED}/usr/$(get_libdir)/${PN}/liblibnyquist.so" || die
}
