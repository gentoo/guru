# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools git-r3

DESCRIPTION="General-purpose software audio FSK modem"
HOMEPAGE="http://www.whence.com/minimodem/"
EGIT_REPO_URI="https://github.com/kamalmostafa/minimodem"

LICENSE="GPL-3+"
SLOT="0"
IUSE="alsa +pulseaudio sndfile sndio"
REQUIRED_USE+="|| ( alsa pulseaudio sndfile sndio )"

DEPEND="sndfile? ( media-libs/libsndfile )
	sci-libs/fftw:3.0
	alsa? ( media-libs/alsa-lib )
	pulseaudio? ( media-libs/libpulse )
	sndio? ( media-sound/sndio )"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
	eapply_user
}

src_configure() {
	my_args="$(use_with alsa) $(use_with pulseaudio) $(use_with sndfile) $(use_with sndio)"
	econf $my_args
}
