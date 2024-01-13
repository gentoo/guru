# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="The DWARF Debugging Information Format"
HOMEPAGE="
	https://www.prevanders.net/dwarf.html
	https://www.dwarfstd.org
	https://github.com/davea42/libdwarf-code
"
SRC_URI="https://www.prevanders.net/${P}.tar.xz"

LICENSE="LGPL-2.1 GPL-2 BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc dwarfexample dwarfgen +elf"

DEPEND="
	sys-libs/zlib
	elf? ( virtual/libelf:= )
"
RDEPEND="${DEPEND}"
BDEPEND="doc? ( app-text/doxygen )"

src_configure() {

	local emesonargs=(
		$(meson_use dwarfgen)
		$(meson_use dwarfexample)
		$(meson_use doc)
		$(meson_use elf libelf)
	)
	meson_src_configure
}

src_install(){
	meson_src_install
	dodoc AUTHORS README README.md ChangeLog* NEWS
	if use doc; then
		mkdir -p "${ED}/usr/share/doc/${PF}" || die
		mv "${ED}/usr/share/doc/${PN}/html" "${ED}/usr/share/doc/${PF}/" || die
		rm -r "${ED}/usr/share/doc/${PN}" || die
	fi
}
