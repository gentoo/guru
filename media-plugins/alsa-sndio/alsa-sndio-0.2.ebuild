# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Sndio audio sink and source for GStreamer"
HOMEPAGE="https://github.com/Duncaen/alsa-sndio"
SRC_URI="https://github.com/Duncaen/alsa-sndio/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	media-libs/alsa-lib
	media-sound/sndio:=
"
RDEPEND="${DEPEND}"

src_prepare() {
	default

	sed -i "s;/lib/alsa-lib/;/$(get_libdir)/alsa-lib/;" Makefile || die "Failed changing libdir"
}

src_install() {
	export PREFIX="/usr"

	default
}
