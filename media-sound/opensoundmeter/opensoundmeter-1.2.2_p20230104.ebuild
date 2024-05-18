# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils desktop

MY_PV="$(ver_cut 1-3)"

DESCRIPTION="FFT based application for tuning sound systems"
HOMEPAGE="https://opensoundmeter.com/en/ https://github.com/psmokotnin/osm"
SRC_URI="
	https://github.com/psmokotnin/osm/archive/refs/tags/v${MY_PV}.tar.gz -> opensoundmeter-${MY_PV}.gh.tar.gz
"

S="${WORKDIR}/osm-${MY_PV}"

# GPL-3 for the codebase
# N-Noise-EULA for the M-Noise noise generator
LICENSE="GPL-3 M-Noise-EULA"
SLOT="0"
KEYWORDS="~amd64"
IUSE="jack"

DEPEND="
	dev-qt/qtcore:5=
	dev-qt/qtnetwork:5=
	dev-qt/qtopengl:5=
	dev-qt/qtquickcontrols2:5=
	dev-qt/qtwidgets:5=
	media-libs/alsa-lib

	jack? (
		virtual/jack
	)
"
RDEPEND="${DEPEND}"
# qtcore for qmake5
BDEPEND="
	dev-qt/qtcore:5
"

PATCHES=(
	# Two patches that just take far too long upstream
	"${FILESDIR}/${PN}-jack-support.patch"
	"${FILESDIR}/${PN}-deadlock-fix.patch"
)

DOCS=( "README.md" )

src_prepare() {
	default
	mkdir -p build || die
}

src_configure() {
	cd build || die
	local myeqmakeargs=()
	use jack && myeqmakeargs+=( "CONFIG+=jack" )

	eqmake5 "${myeqmakeargs[@]}" ../OpenSoundMeter.pro
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
