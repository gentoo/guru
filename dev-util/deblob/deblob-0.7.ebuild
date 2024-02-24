# Copyright 2021-2024 Haelwenn (lanodan) Monnier <contact@hacktivis.me>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ "$PV" == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.sr.ht/~lanodan/deblob"
else
	SRC_URI="https://hacktivis.me/releases/${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~riscv"
fi

DESCRIPTION="remove binary executables from a directory"
HOMEPAGE="https://git.sr.ht/~lanodan/deblob"
LICENSE="BSD"
SLOT="0"

DEPEND="
	>=dev-lang/hare-0.24:=
"
RDEPEND=""

# built by hare
QA_FLAGS_IGNORED="usr/bin/deblob"

src_install() {
	PREFIX="/usr" default
}
