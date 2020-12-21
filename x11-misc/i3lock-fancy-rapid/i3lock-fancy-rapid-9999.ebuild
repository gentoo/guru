# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit git-r3

DESCRIPTION="A faster implementation of i3lock-fancy"
HOMEPAGE="https://github.com/yvbbrjdr/i3lock-fancy-rapid"
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="x11-misc/i3lock-color"

src_install() {
	dobin "${PN}"
}
