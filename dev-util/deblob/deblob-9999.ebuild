# Copyright 2021-2022 Haelwenn (lanodan) Monnier <contact@hacktivis.me>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="remove binary executables from a directory"
HOMEPAGE="https://git.sr.ht/~lanodan/deblob"
EGIT_REPO_URI="https://git.sr.ht/~lanodan/deblob"
LICENSE="BSD"
SLOT="0"

DEPEND="
	dev-lang/hare:=
"
RDEPEND=""

src_install() {
	PREFIX="/usr" default
}
