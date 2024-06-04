# Copyright 2024 

EAPI=8			


DESCRIPTION="kew (/kjuː/) is a command-line music player for Linux."
HOMEPAGE="https://github.com/ravachol/kew"
SRC_URI="https://github.com/ravachol/${PN}/archive/refs/tags/v2.4.4.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND="media-video/ffmpeg
dev-libs/glib
sci-libs/fftw
media-gfx/chafa
media-libs/freeimage
media-libs/opus media-libs/opusfile
media-libs/libvorbis"
RDEPEND=${DEPEND}



src_install()
{
 	emake DESTDIR="${D}" install
}