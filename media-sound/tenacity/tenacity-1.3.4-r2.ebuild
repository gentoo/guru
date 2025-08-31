# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

WX_GTK_VER="3.2-gtk3"

inherit cmake wxwidgets xdg virtualx

# libnyquist doesn't have tags, instead use the specific submodule commit tenacity does
LIBNYQUIST_COMMIT="d4fe08b079538a2fd79277ef1a83434663562f04"

DESCRIPTION="Easy-to-use, privacy-friendly, FLOSS, cross-platform multi-track audio editor"
HOMEPAGE="https://tenacityaudio.org/"
SRC_URI="https://codeberg.org/tenacityteam/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://codeberg.org/tenacityteam/libnyquist/archive/${LIBNYQUIST_COMMIT}.tar.gz -> ${PN}-libnyquist-${PV}.tar.gz"

# codeberg doesn't append tag
S="${WORKDIR}/${PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

IUSE="ffmpeg +midi +lame +id3tag +mp3 mp2 +flac matroska +ogg +vorbis +sbsms +soundtouch +ladspa +lv2 vamp +vst2"
REQUIRED_USE="
	id3tag? ( mp3 )
	lame? ( mp3 )
"

DEPEND="
	sys-libs/zlib
	dev-libs/expat
	media-sound/lame
	media-libs/libsndfile
	media-libs/soxr
	dev-db/sqlite:3
	media-libs/portaudio
	dev-libs/glib:2
	x11-libs/gtk+:3
	x11-libs/wxGTK:${WX_GTK_VER}=[X]

	midi? (
		media-libs/portmidi
		media-libs/portsmf
	)
	id3tag? ( media-libs/libid3tag )
	mp3? ( media-libs/libmad )
	mp2? ( media-sound/twolame )
	matroska? ( media-libs/libmatroska )
	ogg? ( media-libs/libogg )
	vorbis? ( media-libs/libvorbis )
	flac? ( media-libs/flac )
	sbsms? ( media-libs/libsbsms )
	soundtouch? ( media-libs/libsoundtouch )
	ffmpeg? ( media-video/ffmpeg )
	vamp? ( media-libs/vamp-plugin-sdk )
	lv2? (
		media-libs/lv2
		media-libs/lilv
		media-libs/suil
	)

	sys-devel/gettext
	dev-libs/serd
	dev-libs/sord
	media-libs/sratom
	media-libs/taglib
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-1.3.4-fix-rpath-handling.patch"
	"${FILESDIR}/${PN}-1.3.4-fix-hardcoded-docdir.patch"
	"${FILESDIR}/${PN}-1.3.4-ffmpeg-odr-violation-masking.patch"
	"${FILESDIR}/${PN}-1.3.4-odr-and-aliasing-fixes.patch"
)

src_unpack() {
	default

	# otherwise build will try to run git --submodule --init
	rmdir "${S}/lib-src/libnyquist" || die
	ln -s "${WORKDIR}/libnyquist" "${S}/lib-src/libnyquist"
}

src_configure() {
	setup-wxwidgets

	local mycmakeargs=(
		-DVCPKG=OFF
		-DPERFORM_CODESIGN=OFF

		# portage handles this, specify off to stop autodetect
		-DSCCACHE=OFF
		-DCCACHE=OFF

		# Pre-Compiled Headers needs to stay off, even with ccache installed
		# otherwise a bunch of preprocessor variables will be missing
		-DPCH=OFF

		-DMIDI=$(usex midi ON OFF)
		-DID3TAG=$(usex id3tag ON OFF)
		-DMP3_DECODING=$(usex mp3 ON OFF)
		-DMP2=$(usex mp2 ON OFF)
		-DMATROSKA=$(usex matroska ON OFF)
		-DOGG=$(usex ogg ON OFF)
		-DVORBIS=$(usex vorbis ON OFF)
		-DFLAC=$(usex flac ON OFF)
		-DSBSMS=$(usex sbsms ON OFF)
		-DSOUNDTOUCH=$(usex soundtouch ON OFF)
		-DFFMPEG=$(usex ffmpeg ON OFF)
		-DLADSPA=$(usex ladspa ON OFF)
		#-DAUDIO_UNITS=OFF  # option only exists on MacOS
		-DLV2=$(usex lv2 ON OFF)
		-DVAMP=$(usex vamp ON OFF)
		-DVST2=$(usex vst2 ON OFF)

		# this flag is misleading, when not "" the flag only has an effect
		# when CMAKE_GENERATOR is "Visual Studio*" or "XCode" (i.e. not us)
		# man pages will be installed regardless on linux
		-DMANUAL_PATH=""
	)

	cmake_src_configure
}

src_test() {
	virtx cmake_src_test
}
