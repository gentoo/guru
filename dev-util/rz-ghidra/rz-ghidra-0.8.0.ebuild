# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake
DESCRIPTION="An integration of the Ghidra decompiler and Sleigh Disassembler for Rizin."
HOMEPAGE="https://github.com/rizinorg/rz-ghidra"
SRC_URI="https://github.com/rizinorg/rz-ghidra/releases/download/v${PV}/rz-ghidra-src-v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+cutter-plugin"

RDEPEND="
	cutter-plugin? ( dev-util/cutter )
	dev-util/rizin
	dev-libs/pugixml
	"
BDEPEND="
	virtual/pkgconfig
"
S="${WORKDIR}/rz-ghidra"
src_configure(){
	local mycmakeargs=(
		-DUSE_SYSTEM_PUGIXML=ON
	)
	if use cutter-plugin ;then 
		mycmakeargs+=(
			-DBUILD_CUTTER_PLUGIN=ON
			-DCUTTER_INSTALL_PLUGDIR="${EPREFIX}/usr/share/rizin/cutter/plugins/native"
			)
	fi
	cmake_src_configure
}
src_install(){
	cmake_src_install
}

