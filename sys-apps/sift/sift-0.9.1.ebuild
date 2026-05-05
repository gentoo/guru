# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module bash-completion-r1

DESCRIPTION="A fast and powerful alternative to grep."
HOMEPAGE="https://github.com/svent/sift"
SRC_URI="https://github.com/svent/sift/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://codeberg.org/brtz/guru-distfiles/releases/download/${P}-deps.tar.xz/${P}-deps.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

src_compile() {
	ego build .
}

src_install() {
	dobin sift
	dodoc README.md
	newbashcomp "sift-completion.bash" "sift"
}
