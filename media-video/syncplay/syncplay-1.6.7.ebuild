# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )
DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1 optfeature xdg

DESCRIPTION="Client/server to synchronize media playback"
HOMEPAGE="https://github.com/Syncplay/syncplay https://syncplay.pl"
SRC_URI="https://github.com/${PN^}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="+client +server"

RDEPEND="
	dev-python/certifi[${PYTHON_USEDEP}]
	dev-python/twisted[${PYTHON_USEDEP}]
	client? (
		dev-python/QtPy[${PYTHON_USEDEP},gui]
		|| (
			media-video/vlc[lua]
			media-video/mpv[lua]
			media-video/mplayer
		)
	)
"

PATCHES=(
	"${FILESDIR}/${PN}-change-alignment-operator.patch"
	"${FILESDIR}/${PN}-make-qpixmap-to-qicon-conversion-explicit.patch"
	"${FILESDIR}/${PN}-make-qpixmap-to-qicon-conversion-explicit2.patch"
	"${FILESDIR}/${PN}-use-lambda-to-connect-behind-wrapper.patch"
	"${FILESDIR}/${PN}-allow-PyQt5.patch"
)

python_install() {
	local MY_MAKEOPTS=( DESTDIR="${D}" PREFIX=/usr )
	if use client; then
		emake "${MY_MAKEOPTS[@]}" install-client
	fi
	if use server; then
		emake "${MY_MAKEOPTS[@]}" install-server
		newinitd "${FILESDIR}/${PN}-server-init" "${PN}"
		newconfd "${FILESDIR}/${PN}-server-init-conf" "${PN}"
	fi
}

pkg_postinst() {
	xdg_pkg_postinst

	if use client; then
		elog "Syncplay supports the following media players:"
		elog "media-video/mpv, media-video/mplayer, media-video/vlc\n"
		optfeature "using Syncplay with VLC" media-video/vlc[lua]
		optfeature "using Syncplay with MPV" media-video/mpv[lua]
		optfeature "using Syncplay with MPlayer" media-video/mplayer
	fi
}
