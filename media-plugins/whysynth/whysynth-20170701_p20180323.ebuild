# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="A software synthesizer plugin for the DSSI Soft Synth Interface"
HOMEPAGE="http://smbolton.com/whysynth.html https://github.com/smbolton/whysynth"
WHYSYNTH_COMMIT="32e4bc73baa554bb1844b3165e657911f43f3568"
SRC_URI="https://github.com/smbolton/${PN}/archive/${WHYSYNTH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

DEPEND="media-libs/dssi
	media-libs/liblo
	sci-libs/fftw:3.0
	x11-libs/gtk+:2
	media-libs/ladspa-sdk
	media-libs/alsa-lib"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

S="${WORKDIR}/${PN}-${WHYSYNTH_COMMIT}"

src_prepare() {
	./autogen.sh
	default
	eautoreconf
}
