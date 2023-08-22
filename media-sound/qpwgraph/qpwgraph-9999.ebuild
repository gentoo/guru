# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3 xdg

DESCRIPTION="PipeWire Graph Qt GUI Interface"
HOMEPAGE="https://gitlab.freedesktop.org/rncbc/qpwgraph"
EGIT_REPO_URI="https://gitlab.freedesktop.org/rncbc/qpwgraph"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

IUSE="alsa trayicon wayland"

BDEPEND="dev-qt/linguist-tools:5"
DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	dev-qt/qtxml:5
	media-video/pipewire"
RDEPEND="${DEPEND}
	dev-qt/qtsvg:5
"

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCONFIG_ALSA_MIDI=$(usex alsa)
		-DCONFIG_SYSTEM_TRAY=$(usex trayicon)
		-DCONFIG_WAYLAND=$(usex wayland)
		-DCONFIG_QT6=0
	)
	cmake_src_configure
}
