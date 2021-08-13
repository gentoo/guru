# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Identify and manipulate duplicate files"
HOMEPAGE="https://www.jodybruchon.com/software/#jdupes
https://github.com/jbruchon/jdupes"
SRC_URI="https://github.com/jbruchon/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="low-memory"

# ./test.sh: No such file or directory
RESTRICT="test"

DOCS=( CHANGES README.md README.stupid_dupes )

src_configure() {
	tc-export CC
}

src_compile() {
	emake ENABLE_DEDUPE=1 HARDEN=1 LOW_MEMORY=$(usex low-memory 1 0)
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
	einstalldocs
}
