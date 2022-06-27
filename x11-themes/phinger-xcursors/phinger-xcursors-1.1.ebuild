# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Most likely the most over engineered cursor theme"
HOMEPAGE="https://github.com/phisch/phinger-cursors"
SRC_URI="https://github.com/phisch/phinger-cursors/releases/download/v${PV}/phinger-cursors-variants.tar.bz2 -> ${P}.tar.bz2"

LICENSE="CC-BY-SA-4.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="x11-libs/libXcursor"

S="${WORKDIR}"

src_install() {
	insinto /usr/share/cursors/xorg-x11/Phinger
	doins -r phinger-cursors/*

	insinto /usr/share/cursors/xorg-x11/Phinger-Light
	doins -r phinger-cursors-light/*
}
