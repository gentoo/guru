# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="GTK-3 themes: dark, inspired by epic vscode themes"
HOMEPAGE="https://www.gnome-look.org/p/1280977"
EGIT_REPO_URI="https://github.com/EliverLara/Juno"

LICENSE="GPL-3"
SLOT="0"

src_install() {
	insinto /usr/share/themes/${PN}
	doins -r .
}

pkg_postinst() {
	einfo "In order to start SpaceFM (file manager) with it: GTK_THEME=juno spacefm"
	einfo "or"
	einfo "gsettings set org.gnome.desktop.interface gtk-theme 'Juno'"
	einfo "gsettings set org.gnome.desktop.wm gtk-theme 'Juno'"
}
