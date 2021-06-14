# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="The DWARF Debugging Information Format"
HOMEPAGE="
	https://www.prevanders.net/dwarf.html
	http://www.dwarfstd.org
"
SRC_URI="https://www.prevanders.net/${P}.tar.gz"

LICENSE="LGPL-2.1 GPL-2 BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="dwarfexample dwarfgen +elf global-alloc-sums namestable nonstandardprintf oldframecol sanitize"

DEPEND="
	sys-libs/zlib
	elf? ( virtual/libelf )
"
RDEPEND="${DEPEND}"

DOCS=( AUTHORS README README.md ChangeLog ChangeLog2018 NEWS )

src_configure() {

	local myconf=(
		--disable-static
		--disable-windowspath
		--enable-shared
		--includedir="${EPREFIX}/usr/include/${PN}"
	)

	#this configure is so bad it enables when passing --disable
	use dwarfexample && myconf+=(--enable-dwarfexample)
	use dwarfgen && myconf+=(--enable-dwarfgen)
	use elf && myconf+=(--enable-libelf)
	use global-alloc-sums && myconf+=(--enable-global-alloc-csums)
	use namestable && myconf+=(--enable-namestable)
	use nonstandardprintf && myconf+=(--enable-nonstandardprintf)
	use oldframecol && myconf+=(--enable-oldframecol)
	use sanitize && myconf+=(--enable-sanitize)

	econf "${myconf[@]}"
}

src_install(){
	emake DESTDIR="${D}" install
	einstalldocs

	#--disable-static get ignored ...
	find "${ED}" -name '*.a' -delete || die
	find "${ED}" -name '*.la' -delete || die
}
