# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PV="${PV:0:4}-${PV:4:2}-${PV:6:2}"

DESCRIPTION="Theme inspired by Materia design and based on capitaine-cursors"
HOMEPAGE="https://github.com/vinceliuice/Vimix-cursors"
SRC_URI="https://github.com/vinceliuice/Vimix-cursors/archive/refs/tags/${MY_PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/Vimix-cursors-${MY_PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="x11-libs/libXcursor"

src_install() {
	insinto /usr/share/icons/Vimix
	doins -r dist/*

	insinto /usr/share/icons/Vimix-White
	doins -r dist-white/*

	# bugs #838451, #834277, #834001
	dosym ../../../../usr/share/icons/Vimix/cursors /usr/share/cursors/xorg-x11/Vimix
	dosym ../../../../usr/share/icons/Vimix-White/cursors /usr/share/cursors/xorg-x11/Vimix-White
}
