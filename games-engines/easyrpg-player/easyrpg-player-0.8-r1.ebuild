# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake readme.gentoo-r1 xdg

DESCRIPTION="RPG Maker 2000/2003 and EasyRPG games interpreter"
HOMEPAGE="https://easyrpg.org/player/
	https://github.com/EasyRPG/Player"
SRC_URI="https://easyrpg.org/downloads/player/${PV}/${P}.tar.xz"

# EasyRPG Player itself is GPLv3+.
# The program's logos are CC-BY-SA 4.0.
# --
# The program bundles several 3rd-party libraries.
#
# FMMidi files - licensed under the 3-clause BSD license.
# Since the files do not end up in the executable due to the configuration,
# we ignore it.
# - src/midisequencer.cpp
# - src/midisequencer.h
# - src/midisynth.cpp
# - src/midisynth.h
#
# dr_wav files - licensed under (public-domain or MIT-0):
# - src/external/dr_wav.h
# rang files - licensed under the Unlicense:
# - src/external/rang.hpp
# Note that both dr_wav and rang are un-bundled and replaced with versions
# provided by Gentoo packages. However, since these are header-only libraries,
# their licenses are still included in the LICENSE variable.
#
# PicoJSON is used only for Emscripten builds (and unbundled before build).
# --
# The program also uses a couple of 3rd-party fonts. Since these are not
# loaded at runtime, but rather baked into the executable at compile time,
# their licenses are also added to the License tag.
#
# Baekmuk files - licensed under the Baekmuk license:
# - resources/shinonome/korean/
#
# Shinonome files - released into the public domain:
# - resources/shinonome/
#
# ttyp0 files - licensed under the ttyp0 license,
# a variant of the MIT license:
# - resources/ttyp0/
#
# WenQuanYi files - licensed under
# GPLv2-or-later with Font Embedding Exception:
# - resources/wenquanyi/
#
#
# The upstream tarball contains also "Teenyicons", under the MIT license,
# but those are used only for Emscripten builds.

LICENSE="BAEKMUK CC-BY-4.0 GPL-2+-with-font-exception GPL-3+ public-domain
	TTYP0 Unlicense || ( MIT-0 public-domain )"
SLOT="0"

KEYWORDS="~amd64"

IUSE="doc fluidsynth harfbuzz +sound truetype +wildmidi"
REQUIRED_USE="
	fluidsynth? ( sound )
	harfbuzz? ( truetype )
	wildmidi? ( sound )
"

PATCHES=(
	"${FILESDIR}"/${P}-backport-unbundle-dr_wav.patch
	"${FILESDIR}"/${P}-backport-unbundle-rang.patch
	"${FILESDIR}"/${P}-backport-update-for-fmt10.patch
	"${FILESDIR}"/${P}-backport-use-after-free-fluidsynth.patch
	"${FILESDIR}"/${P}-unbundle-picojson.patch
)

DEPEND="
	dev-cpp/rang
	>=dev-games/liblcf-${PV}
	dev-libs/libfmt:=
	media-libs/libpng:=
	>=media-libs/libsdl2-2.0.5[joystick,sound?,video]
	sys-libs/zlib
	x11-libs/pixman
	harfbuzz? ( media-libs/harfbuzz:=[truetype] )
	truetype? ( media-libs/freetype:= )
	sound? (
			 media-libs/dr_wav
			 media-libs/libsndfile
			 media-libs/libvorbis
			 media-libs/opusfile
			 media-libs/speexdsp
			 media-sound/mpg123
			 media-libs/libxmp
			 fluidsynth? ( media-sound/fluidsynth )
			 wildmidi? ( media-sound/wildmidi )
			 !fluidsynth? ( !wildmidi? ( media-libs/alsa-lib ) )
		   )
"
RDEPEND="${DEPEND}
	fluidsynth? ( media-sound/fluid-soundfont )
"
BDEPEND="virtual/pkgconfig
	doc? (
		   app-doc/doxygen
		   media-gfx/graphviz[svg]
		 )
"

DOC_CONTENTS="
EasyRPG Player chooses its library for MIDI output in increasing order:
1. FluidSynth
2. WildMIDI
3. ALSA

With all three enabled, it first tries to send MIDI messages to FluidSynth. If
that fails it falls back to WildMIDI then to ALSA. Currently, the capability to
find and configure a suitable MIDI client through ALSA is limited. It is
recommended to enable one of the other backends, otherwise you are likely to
have no sound.
This package enables support for the ALSA backend only if the other two are
disabled.

For the requirements for suitable ALSA MIDI clients please reference the source
code at src/platform/linux/midiout_device_alsa.cpp
"

src_prepare() {
	# Install prebuilt manpage instead of rebuilding it conditionally.
	sed -i -e "s/if(ASCIIDOCTOR_EXECUTABLE)/if(FALSE)/" \
		-e "s/SUPPORT_AUDIO=1/SUPPORT_AUDIO=$(usex sound 1 0)/" CMakeLists.txt || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DPLAYER_BUILD_LIBLCF=OFF

		# Use the first default choice
		-DPLAYER_WITH_SPEEXDSP=$(usex sound)
		-DPLAYER_WITH_SAMPLERATE=no

		-DPLAYER_WITH_MPG123=$(usex sound)
		-DPLAYER_WITH_OGGVORBIS=$(usex sound)
		-DPLAYER_WITH_OPUS=$(usex sound)
		-DPLAYER_WITH_XMP=$(usex sound)

		# Avoid vendoring, use FluidSynth or WildMIDI (or ALSA) instead
		-DPLAYER_ENABLE_FMMIDI=no
		-DPLAYER_WITH_FLUIDSYNTH=$(usex fluidsynth)
		-DPLAYER_WITH_WILDMIDI=$(usex wildmidi)
		-DPLAYER_WITH_NATIVE_MIDI=$(usex sound $(usex fluidsynth no $(usex wildmidi no yes)) no)
		# Serves as fallback when FluidSynth isn't found
		-DPLAYER_WITH_FLUIDLITE=no
		# Enable dr_wav for faster WAV decoding, fall back to libsndfile
		-DPLAYER_ENABLE_DRWAV=$(usex sound)
		-DPLAYER_WITH_LIBSNDFILE=$(usex sound)

		# The text shaping engine is strictly dependent on the availability
		# of TrueType fonts
		-DPLAYER_WITH_HARFBUZZ=$(usex harfbuzz)
		-DPLAYER_WITH_FREETYPE=$(usex harfbuzz yes $(usex truetype))
	)
	cmake_src_configure
}

src_compile() {
	cmake_src_compile
	if use doc; then
		einfo "Building the documentation might take a while..."
		cmake_build doc
	fi
}

src_test() {
	cmake_build check
}

src_install() {
	cmake_src_install
	if use doc; then
		docinto /usr/share/doc/${PF}/html
		dodoc -r "${BUILD_DIR}"/doc/*
	fi
	readme.gentoo_create_doc
}

pkg_postinst() {
	xdg_pkg_postinst
	readme.gentoo_print_elog
}
