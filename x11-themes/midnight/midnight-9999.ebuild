# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Dark GTK-2, GTK-3, Gnome Shell, Cinnamon & Xfwm4 themes base on Arc-Theme"
HOMEPAGE="https://www.gnome-look.org/p/1273208"
EGIT_REPO_URI="https://github.com/i-mint/midnight"

LICENSE="GPL-3"
SLOT="0"

src_install() {
	insinto /usr/share/themes/${PN}/
	doins -r Midnight/gtk-3.0

	insinto /usr/share/themes/${PN}-green/
	doins -r Midnight-Green/gtk-3.0

	insinto /usr/share/themes/${PN}-red/
	doins -r Midnight-Red/gtk-3.0

	insinto /usr/share/themes/${PN}-olive/
	doins -r Midnight-Olive/gtk-3.0

}

pkg_postinst() {
	einfo "In order to start SpaceFM (file manager) with it: GTK_THEME=midnight spacefm"
	einfo "or"
	einfo "gsettings set org.gnome.desktop.interface gtk-theme midnight"
	einfo "gsettings set org.gnome.desktop.wm gtk-theme midnight"
}
