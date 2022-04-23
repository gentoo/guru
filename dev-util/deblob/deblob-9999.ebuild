# Copyright 2021-2022 Haelwenn (lanodan) Monnier <contact@hacktivis.me>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="remove binary executables from a directory"
EGIT_REPO_URI="https://git.sr.ht/~lanodan/deblob"
LICENSE="BSD"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="
	dev-lang/hare
	test? ( app-text/mandoc )
"
RDEPEND=""

src_compile() {
	default
	mv "${P}" "${PN}" || die
}

src_install() {
	emake install DESTDIR="${D}" PREFIX="/usr"
	einstalldocs
}
