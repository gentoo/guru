# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils

DESCRIPTION="Add64 is a realtime additive/subtractive-synthesis softsynth"
HOMEPAGE="
	https://sourceforge.net/projects/add64/
	http://linuxsynths.com/Add64PatchesDemos/add64.html
"
SRC_URI="https://downloads.sourceforge.net/project/add64/Add64-${PV}.tar.bz2"

S="${WORKDIR}/Add64-${PV}/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~x86"

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	media-libs/alsa-lib
	virtual/opengl
	virtual/jack
"
DEPEND="${RDEPEND}"

src_compile() {
	eqmake5
	default
}

src_install() {
	dobin "${S}/Add64"
	insinto /usr/share/add64/
	doins "${S}/Add64-MIDIconfig"
	insinto /usr/share/add64/Add64Presets
	doins "${S}"/Add64Presets/*
}
