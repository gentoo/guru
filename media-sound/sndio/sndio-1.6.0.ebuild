# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="small audio and MIDI framework part of the OpenBSD project"
HOMEPAGE="http://www.sndio.org/"
SRC_URI="http://www.sndio.org/${P}.tar.gz"
LICENSE="ISC"
SLOT="0/7.0"
KEYWORDS="~amd64"
IUSE="alsa"

DEPEND="
	dev-libs/libbsd
	media-libs/alsa-lib
"
RDEPEND="
	${DEPEND}
	acct-user/sndiod
"

src_configure() {
	./configure \
		--prefix=/usr \
		--libdir=/usr/$(get_libdir) \
		--privsep-user=${PN}d \
		--enable-alsa \
		--with-libbsd
}
