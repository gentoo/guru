# Copyright 2023 Haelwenn (lanodan) Monnier <contact@hacktivis.me>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="RPG Maker 2000/2003 and EasyRPG games interpreter"
HOMEPAGE="https://easyrpg.org/player/"
SRC_URI="https://github.com/EasyRPG/Player/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/Player-${PV}/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc fluidsynth wildmidi"

DEPEND="
	>=dev-games/liblcf-${PV}
	>=media-libs/libsdl2-2.0.5
	media-libs/libpng:=
	x11-libs/pixman
	dev-libs/libfmt:=
	media-libs/freetype:=
	media-libs/harfbuzz:=
	media-libs/alsa-lib

	media-libs/speexdsp

	media-sound/mpg123
	media-libs/libsndfile
	media-libs/libvorbis
	media-libs/opus
	wildmidi? ( media-sound/wildmidi )
	fluidsynth? ( media-sound/fluidsynth )
	media-libs/libxmp

	dev-ruby/asciidoctor

	doc? ( app-text/doxygen )
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DPLAYER_WITH_FLUIDLITE=OFF
		# Avoid vendoring, uses libsndfile instead
		-DPLAYER_ENABLE_DRWAV=OFF

		# Use the first default choice
		-DPLAYER_WITH_SPEEXDSP=ON
		-DPLAYER_WITH_SAMPLERATE=OFF

		-DPLAYER_WITH_MPG123=ON
		-DPLAYER_WITH_LIBSNDFILE=ON
		-DPLAYER_WITH_OGGVORBIS=ON
		-DPLAYER_WITH_OPUS=ON
		-DPLAYER_WITH_WILDMIDI=$(usex wildmidi)
		-DPLAYER_WITH_FLUIDSYNTH=$(usex fluidsynth)
		# Serves as fallback when FluidSynth isn't found
		-DPLAYER_WITH_FLUIDLITE=OFF

		# Avoid vendoring, uses wildmidi or fluidsynth instead
		-DPLAYER_ENABLE_FMMIDI=OFF

		-DPLAYER_WITH_XMP=ON
	)

	cmake_src_configure
}

src_test() {
	cmake_build check
}
