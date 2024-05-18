# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="GTK theme Solarized, multiple colors"
HOMEPAGE="https://www.gnome-look.org/p/1388140"

SRC_URI="https://github.com/rtlewis88/rtl88-Themes/archive/refs/tags/$PV.tar.gz -> PN.tar.gz"
S="$WORKDIR/rtl88-Themes-1.0"

LICENSE="GPL-3"
SLOT="0"

src_install() {
	tar -xvzf solarized-dark-gtk-theme-colorpack_1.3.tar.gz

	insinto /usr/share/themes/
	doins -r Solarized-Dark-*
}

pkg_postinst() {
	local EXAMPLE="Solarized-Dark-Blue-GTK"

	einfo "In order to start SpaceFM (file manager) with it: GTK_THEME=${EXAMPLE} spacefm"
	einfo "or"
	einfo "gsettings set org.gnome.desktop.interface gtk-theme 'EXAMPLE}'"
	einfo "gsettings set org.gnome.desktop.wm gtk-theme 'EXAMPLE}'"
}
