# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils desktop

DESCRIPTION="FFT based application for tuning sound systems"
HOMEPAGE="https://opensoundmeter.com/en/ https://github.com/psmokotnin/osm"
SRC_URI="
	https://github.com/psmokotnin/osm/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz
"

S="${WORKDIR}/osm-${PV}"

# GPL-3 for the codebase
# N-Noise-EULA for the M-Noise noise generator
LICENSE="GPL-3 M-Noise-EULA"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-qt/qtcore:5=
	dev-qt/qtnetwork:5=
	dev-qt/qtopengl:5=
	dev-qt/qtquickcontrols2:5=
	dev-qt/qtwidgets:5=
	media-libs/alsa-lib
"
RDEPEND="${DEPEND}"
# qtcore for qmake5
BDEPEND="
	dev-qt/qtcore:5
"

DOCS=( "README.md" )

src_prepare() {
	default
	mkdir -p build || die
}

src_configure() {
	cd build || die
	eqmake5 ../OpenSoundMeter.pro
}

src_compile() {
	cd build || die
	emake
}

src_install() {
	# The default OpenSoundMeter doesn't respect standard dirs, so we install
	# manually
	dobin build/OpenSoundMeter

	sed "s/Icon=white/Icon=${PN}/g" "OpenSoundMeter.desktop" || die
	domenu "OpenSoundMeter.desktop"
	newicon icons/white.png "${PN}.png"
}
