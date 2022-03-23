# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A cli to browse and watch anime."
HOMEPAGE="https://github.com/pystardust/ani-cli/"
SRC_URI="https://github.com/pystardust/$PN/archive/refs/tags/v$PV.tar.gz -> $P.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-video/mpv
	dev-libs/openssl
	net-misc/curl
	media-video/ffmpeg"

RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	dobin ani-cli

}
