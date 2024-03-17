# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="GTK-3 theme: black background, green font"
HOMEPAGE="https://www.opencode.net/infinity64/hackerer"
EGIT_REPO_URI="https://www.opencode.net/infinity64/hackerer"

LICENSE="GPL-3"
SLOT="0"

src_install() {
	insinto /usr/share/themes/
	doins -r Hackerer
}

pkg_postinst() {
	einfo "In order to start SpaceFM (file manager) with it: GTK_THEME=Hackerer spacefm"
}
