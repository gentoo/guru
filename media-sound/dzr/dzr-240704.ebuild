# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit prefix

DESCRIPTION="DZR: the command line deezer.com player"
HOMEPAGE="https://github.com/yne/dzr"
SRC_URI="https://github.com/yne/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	app-misc/jq[oniguruma]
	dev-libs/openssl
	dev-util/dialog
	media-video/mpv
	net-misc/curl
"

src_install() {
	hprefixify dzr*
	dobin dzr*
}

pkg_postinst() {
	einfo "WARNING: For legal reasons this project"
	einfo "does not contain the track decryption key."
	einfo "Please read the following guide first:"
	einfo "https://github.com/yne/dzr/wiki#find-the-dzr_cbc-key"
}
