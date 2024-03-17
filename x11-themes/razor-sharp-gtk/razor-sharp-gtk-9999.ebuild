# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="GTK-3/4 theme: very dark background, red font"
HOMEPAGE="https://www.gnome-look.org/p/1708445"
NAME="razor-sharp"
EGIT_REPO_URI="https://github.com/nillythel0l/${NAME}"

LICENSE="GPL-3"
SLOT="0"

src_install() {
	insinto /usr/share/themes/${NAME}
	doins -r .
}

pkg_postinst() {
	einfo "In order to start SpaceFM (file manager) with it: GTK_THEME=${NAME} spacefm"
	einfo "or"
	einfo "gsettings set org.gnome.desktop.interface gtk-theme '${NAME}'"
	einfo "gsettings set org.gnome.desktop.wm gtk-theme '${NAME}'"
}
