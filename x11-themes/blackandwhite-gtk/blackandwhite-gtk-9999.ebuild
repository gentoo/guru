# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="GTK-3 theme: simple black-and-white, minimalistic"
HOMEPAGE="https://www.gnome-look.org/p/2010116"
EGIT_REPO_URI="https://www.opencode.net/infinity64/blackandwhite-gtk"

LICENSE="GPL-3"
SLOT="0"

src_install() {
	insinto /usr/share/themes/
	doins -r .
}

pkg_postinst() {
	einfo "In order to start SpaceFM (file manager) with it: GTK_THEME=BlackAndWhite spacefm"
	einfo "or"
	einfo "gsettings set org.gnome.desktop.interface gtk-theme 'BlackAndWhite'"
	einfo "gsettings set org.gnome.desktop.wm gtk-theme 'BlackAndWhite'"
}
