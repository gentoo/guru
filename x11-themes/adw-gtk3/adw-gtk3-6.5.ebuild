# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg

DESCRIPTION="An unofficial GTK3 port of libadwaita"
HOMEPAGE="https://github.com/lassekongo83/adw-gtk3"
SRC_URI="https://github.com/lassekongo83/adw-gtk3/releases/download/v${PV}/adw-gtk3v${PV}.tar.xz"
S=${WORKDIR}

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RESTRICT="binchecks strip"

src_install() {
	insinto /usr/share/themes
	doins -r adw-gtk3{,-dark}
}
