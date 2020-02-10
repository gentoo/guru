# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_7 )

DISTUTILS_USE_SETUPTOOLS=rdepend

inherit eutils distutils-r1 xdg-utils

DESCRIPTION="Watch live music videos for the songs playing on your device"
HOMEPAGE="https://github.com/vidify/vidify"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="+vlc mpv"

REQUIRED_USE="|| ( vlc mpv )"

RDEPEND="
	dev-python/appdirs[${PYTHON_USEDEP}]
	dev-python/lyricwikia[${PYTHON_USEDEP}]
	dev-python/pydbus[${PYTHON_USEDEP}]
	dev-python/QtPy[gui,webengine,${PYTHON_USEDEP}]
	dev-python/tekore[${PYTHON_USEDEP}]
	net-misc/youtube-dl[${PYTHON_USEDEP}]
	mpv? ( dev-python/python-mpv[${PYTHON_USEDEP}] )
	vlc? ( dev-python/python-vlc[${PYTHON_USEDEP}] )"

# Tests work (mostly) outside of emerge, but core dump inside emerge/virtx

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update

	use mpv && elog "media-video/vlc is the default vidify player, to use mpv run 'vidify --player mpv' or set 'player = mpv' in the config file"
	use vlc && elog "If video playback is not working please check 'vidify --debug' for missing-codec-errors and recompile media-video/vlc with the missing codecs"
	use mpv && elog "If video playback is not working please check 'vidify --player mpv --debug' for missing-codec-errors and recompile media-video/mpv with the missing codecs"

	optfeature "'vidify --dark-mode'" dev-python/qdarkstyle
	optfeature "'vidify --audiosync'" media-video/vidify-audiosync
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
