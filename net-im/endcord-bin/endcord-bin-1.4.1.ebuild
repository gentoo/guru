# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit optfeature

DESCRIPTION="Feature rich Discord TUI client"
HOMEPAGE="https://github.com/sparklost/endcord"

SRC_URI="https://github.com/sparklost/endcord/releases/download/${PV}/endcord-${PV}-linux.tar.gz"
S="${WORKDIR}"

LICENSE="GPL-3"
SLOT=0
KEYWORDS="-* ~amd64"

RESTRICT="strip"

QA_PREBUILT="usr/bin/endcord-bin"

src_install() {
	newbin endcord endcord-bin
}

pkg_postinst() {
	optfeature "clipboard support on X11" x11-misc/xclip
	optfeature "clipboard support on Wayland" gui-apps/wl-clipboard

	optfeature "file dialog when uploading" \
		app-misc/yazi \
		gnome-extra/zenity \
		kde-apps/kdialog

	optfeature "spellchecking (requires aspell dictionary such as aspell-en)" \
		app-text/aspell

	optfeature "install and update extensions from other sources" \
		dev-vcs/git

	optfeature "YouTube support" net-misc/yt-dlp
	optfeature "play YouTube videos in native player (non-ASCII support)" media-video/mpv

	optfeature "store token in system keyring (requires gnome-keyring running under dbus)" \
		app-crypt/libsecret
}
