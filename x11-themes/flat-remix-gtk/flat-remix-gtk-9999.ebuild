# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Black flat with a colorful palette, some shadows, highlights, gradients"
HOMEPAGE="https://www.gnome-look.org/p/1293697"

VERSION="20220627"
SRC_URI="https://github.com/daniruiz/${PN}/archive/refs/tags/${VERSION}.tar.gz"
S=${WORKDIR}/${PN}-${VERSION}

LICENSE="GPL-3"
SLOT="0"

src_install() {
	insinto /usr/share/themes/
	doins -r themes/*
}

pkg_postinst() {
	local EXAMPLE="Flat-Remix-Dark-Metacity"

	einfo "In order to start SpaceFM (file manager) with it: GTK_THEME=${EXAMPLE} spacefm"
	einfo "or"
	einfo "gsettings set org.gnome.desktop.interface gtk-theme 'EXAMPLE}'"
	einfo "gsettings set org.gnome.desktop.wm gtk-theme 'EXAMPLE}'"
}
