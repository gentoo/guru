# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="GTK-3/4 theme: black background, blue accent"
HOMEPAGE="https://www.gnome-look.org/p/1553851"
EGIT_REPO_URI="https://gitlab.com/tearch-linux/artworks/themes-and-icons/adwaita-dark-amoled.git"

LICENSE="GPL-3"
SLOT="0"

src_install() {
	insinto /usr/share/themes/${PN}
	doins -r .
}

pkg_postinst() {
	einfo "In order to start SpaceFM (file manager) with it: GTK_THEME=${PN} spacefm"
	einfo "or"
	einfo "gsettings set org.gnome.desktop.interface gtk-theme '${PN}'"
	einfo "gsettings set org.gnome.desktop.wm gtk-theme '${PN}'"
}
