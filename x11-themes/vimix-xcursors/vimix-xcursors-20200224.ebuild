# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Vimix-cursors for Linux desktop."
HOMEPAGE="https://github.com/vinceliuice/Vimix-cursors"
SRC_URI="https://github.com/vinceliuice/Vimix-cursors/archive/refs/tags/2020-02-24.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/Vimix-cursors-${PV:0:4}-${PV:4:2}-${PV:6:2}"

src_install() {
	insinto /usr/share/cursors/xorg-x11/Vimix/cursors
	doins -r dist/cursors/*

	insinto /usr/share/cursors/xorg-x11/Vimix-White/cursors
	doins -r dist-white/cursors/*
}
