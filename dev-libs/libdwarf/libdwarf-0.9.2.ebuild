# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

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
IUSE="test doc dwarfexample dwarfgen"
RESTRICT="!test? ( test )"

DEPEND="
	app-arch/zstd:=
	sys-libs/zlib:=
"
RDEPEND="${DEPEND}"

DOCS=( AUTHORS NEWS README.md )

PATCHES=( "${FILESDIR}/${P}-fix-include-patch.patch" )

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED=ON
		-DBUILD_DWARFGEN=$(usex dwarfgen)
		-DBUILD_DWARFEXAMPLE=$(usex dwarfexample)
		-DDO_TESTING=$(usex test)
	)

	cmake_src_configure
}

src_install(){
	cmake_src_install

	dodoc ChangeLog* doc/*.pdf
	if use doc; then
		mv "${ED}"/usr/share/doc/${PN}/* "${ED}"/usr/share/doc/${PF}/ || die
		rmdir "${ED}"/usr/share/doc/${PN} || die
	fi
}
