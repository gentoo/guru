# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs

DESCRIPTION="GHDL plugin for yosys (VHDL synthesis)"
HOMEPAGE="https://github.com/ghdl/ghdl-yosys-plugin"
SRC_URI="https://github.com/ghdl/ghdl-yosys-plugin/archive/refs/tags/ghdl-v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-ghdl-v${PV}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	sci-electronics/yosys
	=sci-electronics/ghdl-6.0.0*
"
RDEPEND="${DEPEND}"

src_compile() {
	local gcc_ver=$(gcc-major-version)
	local adalib_path="/usr/lib/gcc/${CHOST}/${gcc_ver}/adalib"

	append-ldflags "-Wl,-rpath=${adalib_path}" "-Wl,--disable-new-dtags"
	append-cxxflags "-Wl,-rpath=${adalib_path}" "-Wl,--disable-new-dtags"

	emake \
		CC="$(tc-getCC)" \
		CXX="$(tc-getCXX)" \
		LDFLAGS="${LDFLAGS}"
}

src_install() {
	emake PREFIX="/usr" DESTDIR="${D}" install
}
