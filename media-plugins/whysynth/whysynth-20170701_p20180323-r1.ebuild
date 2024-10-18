# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="A software synthesizer plugin for the DSSI Soft Synth Interface"
HOMEPAGE="https://smbolton.com/whysynth.html https://github.com/theabolton/whysynth"
WHYSYNTH_COMMIT="32e4bc73baa554bb1844b3165e657911f43f3568"
SRC_URI="https://github.com/theabolton/${PN}/archive/${WHYSYNTH_COMMIT}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${WHYSYNTH_COMMIT}"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

DEPEND="
	dev-libs/glib:2
	media-libs/alsa-lib
	media-libs/dssi
	media-libs/ladspa-sdk
	media-libs/liblo
	sci-libs/fftw:3.0=
	x11-libs/cairo
	x11-libs/gtk+:2
"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	./autogen.sh || die
	default
	eautoreconf
}

src_install() {
	default
	find "${ED}" -type f -name '*.la' -delete || die
}
