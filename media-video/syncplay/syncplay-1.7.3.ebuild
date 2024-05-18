# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
DISTUTILS_SINGLE_IMPL=1

inherit desktop distutils-r1 optfeature xdg

DESCRIPTION="Client/server to synchronize media playback"
HOMEPAGE="https://github.com/Syncplay/syncplay https://syncplay.pl"
SRC_URI="https://github.com/${PN^}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+client server +gui"
REQUIRED_USE="|| ( client server )"

RDEPEND="
	$( python_gen_cond_dep \
		'>=dev-python/certifi-2018.11.29[${PYTHON_USEDEP}]
		>=dev-python/twisted-16.4.0[${PYTHON_USEDEP},ssl]
		>=dev-python/pem-21.2.0[${PYTHON_USEDEP}]'
	)
	client? (
		gui? (
			$( python_gen_cond_dep \
				'dev-python/QtPy[${PYTHON_USEDEP},gui,pyside2]' \
				python3_{10,11}
			)
			$( python_gen_cond_dep \
				'dev-python/QtPy[${PYTHON_USEDEP},gui,pyside6]' \
				python3_12
			)
		)
		|| (
			media-video/vlc[lua]
			media-video/mpv[lua]
			media-video/mplayer
		)
	)
"

python_install() {
	python_domodule syncplay

	if use gui; then
		for size in 256 128 96 64 48 32 24 16; do
			doicon -s ${size} "${PN}/resources/hicolor/${size}x${size}/apps/syncplay.png"
		done
	fi
	if use client; then
		python_newscript syncplayClient.py syncplay
		if use gui; then
			domenu syncplay/resources/syncplay.desktop
		fi
	fi
	if use server; then
		if use gui; then
			domenu syncplay/resources/syncplay-server.desktop
		fi
		python_newscript syncplayServer.py syncplay-server
		newinitd "${FILESDIR}/${PN}-server-init" "${PN}"
		newconfd "${FILESDIR}/${PN}-server-init-conf" "${PN}"
	fi
}

pkg_postinst() {
	xdg_pkg_postinst

	if use client; then
		optfeature_header "Syncplay is compatible with the following players, install:"
		optfeature "VLC support" media-video/vlc[lua]
		optfeature "MPV support" media-video/mpv[lua]
		optfeature "MPlayer support" media-video/mplayer
	fi
}
