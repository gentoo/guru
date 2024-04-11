# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Interactive rg (ripgrep) wrapper in fzf: Interactive GRep (search)"
HOMEPAGE="https://github.com/DanielFGray/fzf-scripts"
SRC_URI="https://raw.githubusercontent.com/DanielFGray/fzf-scripts/master/$PN"

LICENSE="GPL-3"
SLOT=0

RDEPEND="
	sys-apps/ripgrep
	app-shells/fzf
	sys-apps/bat
"

S="$WORKDIR"

src_unpack() {
	cp "$DISTDIR/$PN" "$WORKDIR/" || die
}

PATCHES=(
	"$FILESDIR/vim-open-current-line.patch"
)

src_install() {
	dobin "${PN}"
}

pkg_postinst() {
	einfo "For opening a file on the specific line - install https://github.com/bogado/file-line"
}
