# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9} )
DISTUTILS_USE_SETUPTOOLS=rdepend
DISTUTILS_SINGLE_IMPL=1

inherit desktop distutils-r1 optfeature xdg

DESCRIPTION="Client/server to synchronize media playback"
HOMEPAGE="https://github.com/Syncplay/syncplay https://syncplay.pl"
SRC_URI="https://github.com/${PN^}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="+client +server"
REQUIRED_USE="|| ( client server )"

RDEPEND="
	$( python_gen_cond_dep \
	'dev-python/certifi[${PYTHON_USEDEP}]
	dev-python/twisted[${PYTHON_USEDEP}]'
	)
	client? (
		$( python_gen_cond_dep \
		'dev-python/QtPy[${PYTHON_USEDEP},gui]'
		)
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
	python_domodule syncplay
	for size in 256 128 96 64 48 32 24 16; do
		doicon -s ${size} "${PN}/resources/hicolor/${size}x${size}/apps/syncplay.png"
	done
	if use client; then
		python_newscript syncplayClient.py syncplay
		domenu syncplay/resources/syncplay.desktop
	fi
	if use server; then
		python_newscript syncplayServer.py syncplay-server
		domenu syncplay/resources/syncplay-server.desktop
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
