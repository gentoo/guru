# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="A set of C++ classes that provide a common API for realtime MIDI input/output"
HOMEPAGE="http://www.music.mcgill.ca/~gary/rtmidi"
SRC_URI="http://www.music.mcgill.ca/~gary/rtmidi/release/${P}.tar.gz"

LICENSE="RtMidi"
SLOT="0"
RESTRICT="mirror"
KEYWORDS="~amd64 ~x86"
IUSE="+alsa jack"

DEPEND="
	alsa? ( media-libs/alsa-lib )
	jack? ( virtual/jack )
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	mycmakeargs+=(
		-DRTMIDI_API_ALSA=$(usex alsa)
		-DRTMIDI_API_JACK=$(usex jack)
	)

	cmake_src_configure
}
