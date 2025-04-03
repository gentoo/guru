# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
inherit distutils-r1 pypi

DESCRIPTION="Python-based chip (RTL) verification"
HOMEPAGE="https://www.cocotb.org"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~riscv ~x86"

# Tests requires many eda tools, and can't work inside network sandbox
RESTRICT=test

RDEPEND="
	dev-python/find-libpython[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/cocotb-1.9.2-fix-license-qa.patch"
)

src_compile() {
	# parallel build is broken
	MAKEOPTS="-j1" distutils-r1_src_compile
}

python_test() {
	epytest
}

pkg_postinst() {
	elog "cocotb requires a HDL simulator to function correctly."
	elog "You may want to install one of the following packages:"
	elog "  sci-electronics/icarus-verilog - Verilog simulator"
	elog "  sci-electronics/ghdl - VHDL simulator"
	elog "  sci-electronics/verilator - Fast Verilog simulator"
	elog ""
	elog "Commercial EDA tools are also supported, including:"
	elog "  - Synopsys VCS"
	elog "  - Cadence Xcelium/Incisive"
	elog "  - Siemens EDA Modelsim/Questa"
	elog "  - Aldec Riviera-PRO"
	elog "Note: These commercial tools need to be obtained from their respective vendors"
}
