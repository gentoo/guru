# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Double Commander: file manager with two panels, similar to Total Commander"
HOMEPAGE="https://doublecmd.sourceforge.io/"

S="${WORKDIR}"

LICENSE="GPL-2"
SLOT="0"
PROPERTIES="live"
IUSE="+gtk qt5"
REQUIRED_USE=" ^^ ( gtk qt5 ) "

RESTRICT="strip"

RDEPEND="sys-fs/fuse:0"

QA_PREBUILT="*"

src_unpack() {
	if use gtk; then
		wget https://download.opensuse.org/repositories/home:/Alexx2000/AppImage/doublecmd-gtk-latest-x86_64.AppImage
	else
		wget https://download.opensuse.org/repositories/home:/Alexx2000/AppImage/doublecmd-qt-latest-x86_64.AppImage
	fi
}

src_install() {
	newbin *.AppImage doublecmd-appimage
}
