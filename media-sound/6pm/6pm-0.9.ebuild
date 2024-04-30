# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils

DESCRIPTION="6PM is a polyphonic, touch-sensitive, realtime phase modulation synthesizer"
HOMEPAGE="https://sourceforge.net/projects/mv-6pm/"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="+presets +midimaps +nls doc"
MY_P="6PM_v${PV}"
SRC_URI="https://downloads.sourceforge.net/project/mv-6pm/${MY_P}.tgz -> ${P}.tgz"
LICENSE="GPL-3"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	virtual/opengl
	virtual/jack
	media-libs/alsa-lib
"
RDEPEND="${DEPEND}"
S="${WORKDIR}/${MY_P}/src/"
ADIR="${WORKDIR}/${MY_P}"

src_configure(){
	eqmake5
	default
}

src_install(){
	default
	dobin "${S}/6pm"
	if use midimaps; then
		insinto /usr/share/6pm/MidiMaps
		doins ${ADIR}/MidiMaps/*
	fi
	if use presets; then
		dodir /usr/share/6pm/
		cp -R "${ADIR}/Presets/" "${D}/usr/share/6pm/" || die "Can't install presets"
		elog "You also may download additional patches from http://linuxsynths.com/6PMPatchesDemos/6pm.html"
	fi
	if use doc; then
		insinto /usr/share/6pm/Doc
		doins "${ADIR}"/Doc/*
	fi
	if use nls; then
		insinto /usr/share/6pm/Translations
		doins "${ADIR}"/Translations/*
	fi
}
