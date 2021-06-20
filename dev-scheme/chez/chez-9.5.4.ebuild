# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A programming language based on R6RS"
HOMEPAGE="https://cisco.github.io/ChezScheme/ https://github.com/cisco/ChezScheme"
SRC_URI="https://github.com/cisco/ChezScheme/releases/download/v${PV}/csv${PV}.tar.gz"

# Chez Scheme itself is Apache 2.0, but it vendors LZ4 (BSD-2),
# Nanopass (MIT), stex (MIT), and zlib (ZLIB).
LICENSE="Apache-2.0 BSD-2 MIT ZLIB"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples"

S="${WORKDIR}"/csv${PV}

src_configure() {
	local myconfargs=(
		--installschemename=chezscheme
		--installpetitename=chezscheme-petite
		--installscriptname=chezscheme-script
		--installprefix="${EPREFIX}"/usr
		--nogzip-man-pages
		--disable-curses # TODO: ncurses USE flag.
		--disable-x11 # TODO: X USE flag.
	)

	./configure "${myconfargs[@]}" || die
}

src_install() {
	emake install TempRoot="${D}"
	use examples || rm -r "${D}"/usr/lib/csv${PV}/examples || die
}
