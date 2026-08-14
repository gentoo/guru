# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
LLVM_COMPAT=( {18..21} )

inherit cmake python-any-r1 llvm-r2

DESCRIPTION="framework for Verilog RTL synthesis"
HOMEPAGE="https://yosyshq.net/yosys/"
SRC_URI="
	https://github.com/YosysHQ/${PN}/releases/download/v${PV}/yosys.tar.gz -> ${P}.tar.gz
"
S="${WORKDIR}/${P}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
RDEPEND="
	dev-libs/boost:=
	dev-libs/libffi:=
	dev-lang/tcl:=
	$(llvm_gen_dep '
		llvm-core/clang:${LLVM_SLOT}=
	')
	media-gfx/xdot
	sys-libs/ncurses:=
	sys-libs/readline:=
	virtual/zlib
"

DEPEND="${RDEPEND}"
BDEPEND="
	${PYTHON_DEPS}
	app-alternatives/lex
	app-alternatives/yacc
	dev-vcs/git
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}"/${P}-respect-flags.patch
	"${FILESDIR}"/${P}-cmake4-compat.patch
)

pkg_setup() {
	# llvm-r2 and python-any-r1 both export pkg_setup and llvm-r2 wins,
	# leaving PYTHON unset, so call python_setup ourselves.
	llvm-r2_pkg_setup
	python_setup
}

src_unpack() {
	mkdir "${S}" || die
	cd "${S}" || die
	unpack ${A}
}

src_configure() {
	local mycmakeargs=(
		-DYOSYS_WITHOUT_SLANG=ON
		-DYOSYS_WITH_PYTHON=OFF
		-DYOSYS_INSTALL_DRIVER=ON
		-DPython3_EXECUTABLE="${PYTHON}"
		-DCMAKE_DISABLE_FIND_PACKAGE_GTest=ON
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install

	# yosys-smtbmc and yosys-witness keep an env python3 shebang that
	# breaks under python-exec[-native-symlinks]; retarget them at EPYTHON.
	python_fix_shebang "${ED}"/usr/bin/yosys-smtbmc "${ED}"/usr/bin/yosys-witness
}
