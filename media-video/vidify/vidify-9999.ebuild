# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )

DISTUTILS_USE_SETUPTOOLS=rdepend

inherit eutils desktop distutils-r1 git-r3 xdg-utils

DESCRIPTION="Watch live music videos for the songs playing on your device"
HOMEPAGE="https://github.com/marioortizmanero/spotify-music-videos"
EGIT_REPO_URI="https://github.com/marioortizmanero/spotify-music-videos.git"
EGIT_BRANCH="next"

LICENSE="MIT"
SLOT="0"
KEYWORDS=

IUSE="+vlc mpv"

REQUIRED_USE="|| ( vlc mpv )"

RDEPEND="
	dev-python/pydbus[${PYTHON_USEDEP}]
	dev-python/QtPy[gui,webengine,${PYTHON_USEDEP}]
	dev-python/lyricwikia[${PYTHON_USEDEP}]
	vlc? ( dev-python/python-vlc[${PYTHON_USEDEP}] )
	mpv? ( dev-python/python-mpv[${PYTHON_USEDEP}] )
	net-misc/youtube-dl[${PYTHON_USEDEP}]
	dev-python/appdirs[${PYTHON_USEDEP}]
	dev-python/tekore[${PYTHON_USEDEP}]"

python_install_all() {
	distutils-r1_python_install_all
	newicon -s scalable vidify/gui/res/icon.svg ${PN}.svg
	if use mpv && use !vlc; then
		make_desktop_entry "${PN} --player mpv" "Vidify" "${PN}" "AudioVideo;Music"
	elif use mpv && use vlc; then
		make_desktop_entry "${PN} --player mpv" "Vidify (mpv)" "${PN}" "AudioVideo;Music"
		make_desktop_entry "${PN}" "Vidify (vlc)" "${PN}" "AudioVideo;Music"
	else
		make_desktop_entry "${PN}" "Vidify" "${PN}" "AudioVideo;Music"
	fi
}

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
