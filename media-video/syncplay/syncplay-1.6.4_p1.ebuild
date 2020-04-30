# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )
DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1 eutils xdg

MYPV="${PV/_p1/a}"

DESCRIPTION="Client/server to synchronize media playback"
HOMEPAGE="https://github.com/Syncplay/syncplay https://syncplay.pl"
SRC_URI="https://github.com/${PN^}/${PN}/archive/v${MYPV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="+client +server vlc mpv"
REQUIRED_USE="vlc? ( client ) mpv? ( client )"

RDEPEND="
	dev-python/certifi[${PYTHON_USEDEP}]
	dev-python/twisted[${PYTHON_USEDEP}]
	vlc? ( media-video/vlc[lua] )
	mpv? ( media-video/mpv[lua] )
"

# RDEPEND on PySide2 for gui, but not packaged here at the moment
# It is a too big and complex package for me to maintain
# You can find PySide2 in the ::raiagent overlay

S="${WORKDIR}/${PN}-${MYPV}"

python_install() {
	local MY_MAKEOPTS=( DESTDIR="${D}" PREFIX=/usr )
	use client && \
		emake "${MY_MAKEOPTS[@]}" install-client
	use server && \
		emake "${MY_MAKEOPTS[@]}" install-server

	newinitd "${FILESDIR}/${PN}-server-init" "${PN}"
	newconfd "${FILESDIR}/${PN}-server-init-conf" "${PN}"
}

pkg_postinst() {
	xdg_pkg_postinst

	optfeature "using the GUI (you can find it in the raiagent overlay)\n" dev-python/pyside2

	if use client; then
		elog "Syncplay supports the following players:"
		elog "media-video/mpv, media-video/mplayer2, media-video/vlc"
	fi
}
