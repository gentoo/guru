# Copyright 1999-2023 Gentoo Authors
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

LICENSE="BSD GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc dwarfexample dwarfgen +elf"

DEPEND="
	app-arch/zstd:=
	sys-libs/zlib:=
	elf? ( virtual/libelf:= )
"
RDEPEND="${DEPEND}"
BDEPEND="doc? ( app-text/doxygen )"

DOCS=( AUTHORS NEWS README.md )

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

	dodoc ChangeLog* doc/*.pdf
	if use doc; then
		mv "${ED}"/usr/share/doc/${PN}/* "${ED}"/usr/share/doc/${PF}/ || die
		rmdir "${ED}"/usr/share/doc/${PN} || die
	fi
}
