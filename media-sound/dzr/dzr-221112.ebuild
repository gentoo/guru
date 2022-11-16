# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="DZR: the command line deezer.com player"
HOMEPAGE="https://github.com/yne/dzr"
SRC_URI="https://github.com/yne/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	app-misc/jq[oniguruma]
	dev-libs/openssl
	dev-util/dialog
	media-video/mpv
	net-misc/curl
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	exeinto /usr/bin
	doexe dzr
	doexe dzr-dec
	doexe dzr-id3
	doexe dzr-srt
	doexe dzr-url
	default
}

pkg_postinst() {
	einfo "WARNING: For legal reasons this project"
	einfo "does not contain the track decryption key."
	einfo "Please read the following guide first:"
	einfo "https://github.com/yne/dzr/wiki#find-the-dzr_cbc-key"
}
