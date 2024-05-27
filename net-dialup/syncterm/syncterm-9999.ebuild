# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 desktop

DESCRIPTION="BBS (bulletin board system) terminal"
HOMEPAGE="https://syncterm.bbsdev.net/"
EGIT_REPO_URI="https://gitlab.synchro.net/main/sbbs"

LICENSE="GPL-2+"
SLOT="0"
IUSE="ncurses sdl X"

DEPEND="ncurses? ( sys-libs/ncurses )
	sdl? ( media-libs/libsdl2 )
	X? ( x11-libs/libX11 )"
RDEPEND="${DEPEND}"

src_compile() {
	# FIXME: probably bad form
	cd "${S}/src/syncterm"

	# NOTE: build system automatically detects whether
	# optional dependencies are there, strangely

	emake
	emake syncterm.man

	# doman complains about wrong filename otherwise
	cp syncterm.man syncterm.1
}

src_install() {
	# Regular ‘emake install’ violates policy in multiple ways
	dobin src/syncterm/gcc.linux.x64.exe.debug/syncterm
	doicon src/syncterm/syncterm.png
	domenu src/syncterm/syncterm.desktop
	doman src/syncterm/syncterm.1

	# Things not installed by ‘emake install’
	dodoc src/syncterm/CHANGES
}
