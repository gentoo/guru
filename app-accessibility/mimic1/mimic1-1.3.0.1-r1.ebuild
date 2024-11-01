# Copyright 2019-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/MycroftAI/mimic1.git"
else
	SRC_URI="https://github.com/MycroftAI/mimic1/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Mycroft's TTS engine, based on CMU's Flite (Festival Lite)"
HOMEPAGE="https://community.openconversational.ai/"

LICENSE="BSD MIT public-domain freetts BSD-2 Apache-2.0"
SLOT="0"
# Note: supports Sun/NetBSD audio
IUSE="alsa portaudio pulseaudio oss"

DEPEND="
	dev-libs/libpcre2
	dev-libs/hts_engine
	alsa? ( media-libs/alsa-lib )
	portaudio? ( media-libs/portaudio )
	pulseaudio? ( media-libs/libpulse )
"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}/${P}-gcc10.patch"
	# bug 859640
	"${FILESDIR}/${P}-lto.patch"
)

src_prepare() {
	default
	sed -i 's/-Werror //' Makefile.am || die
	eautoreconf
}
