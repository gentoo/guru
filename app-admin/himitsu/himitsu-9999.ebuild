# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Secret storage system for Unix, suitable for storing passwords, keys, ..."
HOMEPAGE="https://git.sr.ht/~sircmpwn/himitsu"
EGIT_REPO_URI="https://git.sr.ht/~sircmpwn/himitsu"
LICENSE="GPL-3"
SLOT="0"

IUSE=""

DEPEND="
	dev-lang/hare:=
"
RDEPEND="
	gui-apps/hiprompt-gtk-py
"

src_configure() {
	sed -i 's;^PREFIX=.*;PREFIX=/usr;' Makefile || die
}
