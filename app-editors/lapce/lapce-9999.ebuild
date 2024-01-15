# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

inherit cargo desktop git-r3 xdg-utils

DESCRIPTION="Lightning-fast and Powerful Code Editor written in Rust "
HOMEPAGE="https://github.com/lapce/lapce"
EGIT_REPO_URI="https://github.com/lapce/lapce.git"

LICENSE="( Apache-2.0 ( MIT 0BSD ) Apache-2.0-with-LLVM-exceptions Artistic-2 BSD BSD-2 Boost-1.0 CC0-1.0 CeCILL-2 GPL-2 ISC MIT MIT ) MPL-2.0 Unicode-DFS-2016 Unlicense ZLIB"
SLOT="0"

DEPEND="
	x11-libs/gtk+:3
	media-libs/fontconfig
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-build/cmake
	sys-devel/gcc
	virtual/pkgconfig
	>=virtual/rust-1.64
"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_configure() {
	cargo_src_configure --frozen
}

src_install() {
	cargo_src_install
	domenu extra/linux/dev.lapce.lapce.desktop
	newicon extra/images/logo.png dev.lapce.lapce.png
}

pkg_postrm() {
	xdg_desktop_database_update
}
