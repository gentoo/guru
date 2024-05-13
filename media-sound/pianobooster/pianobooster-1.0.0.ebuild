# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake xdg

DESCRIPTION="A MIDI player/game that displays notes and teaches you how to play the piano"
HOMEPAGE="https://www.pianobooster.org"
SRC_URI="https://github.com/pianobooster/PianoBooster/archive/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/PianoBooster-${PV}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="jack"
RESTRICT="mirror"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtopengl:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	media-libs/ftgl
	media-libs/rtmidi[jack?]
	media-sound/fluidsynth
	jack? ( virtual/jack )
	virtual/opengl"

RDEPEND="${DEPEND}"
BDEPEND="
	virtual/pkgconfig
	dev-qt/linguist-tools:5"

src_prepare() {

	# Substitute because debian-based distros use /usr/include/rtmidi/RtMidi.h
	# instead of the RtMidi's default /usr/include/RtMidi.h
	sed -i -e "s/rtmidi\/RtMidi.h/RtMidi.h/g" src/GuiKeyboardSetupDialog.cpp || die "Couldn't fix rtmidi headers!"
	sed -i -e "s/rtmidi\/RtMidi.h/RtMidi.h/g" src/MidiDeviceRt.h || die "Couldn't fix rtmidi headers!"

	sed -i -e "s/share\/doc\/pianobooster/share\/doc\/${P}/g" src/CMakeLists.txt || die "Couldn't fix CMakeLists!"

	cmake_src_prepare
}

src_configure() {
	mycmakeargs+=(
		-DUSE_JACK=$(usex jack)
	)

	cmake_src_configure
}
