# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PV="${PV:0:4}-${PV:4:2}-${PV:6:2}"

DESCRIPTION="Vimix-cursors for Linux desktop"
HOMEPAGE="https://github.com/vinceliuice/Vimix-cursors"
SRC_URI="https://github.com/vinceliuice/Vimix-cursors/archive/refs/tags/${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/Vimix-cursors-${MY_PV}"

src_install() {
	insinto /usr/share/cursors/xorg-x11/Vimix/cursors
	doins -r dist/cursors/*

	insinto /usr/share/cursors/xorg-x11/Vimix-White/cursors
	doins -r dist-white/cursors/*
}
