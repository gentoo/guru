# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
LLVM_COMPAT=( {18..21} )

inherit python-any-r1 llvm-r2

DESCRIPTION="framework for Verilog RTL synthesis"
HOMEPAGE="https://yosyshq.net/yosys/"
SRC_URI="
	https://github.com/YosysHQ/${PN}/releases/download/v${PV}/yosys.tar.gz -> ${P}.tar.gz
"
S="${WORKDIR}"

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
	dev-vcs/git
	virtual/pkgconfig
"

pkg_setup() {
	# llvm-r2 and python-any-r1 both export pkg_setup and llvm-r2 wins,
	# leaving PYTHON unset, so call python_setup ourselves.  An empty
	# PYTHON_EXECUTABLE makes the Makefile run helper scripts via their env
	# python3 shebang, which breaks with python-exec[-native-symlinks].
	llvm-r2_pkg_setup
	python_setup
}

src_configure() {
	cat <<-__EOF__ >> Makefile.conf || die
		PREFIX := ${EPREFIX}/usr
		STRIP := @echo "skipping strip"
		CXXFLAGS += ${CXXFLAGS}
		LINKFLAGS += ${LDFLAGS}
		PYTHON_EXECUTABLE := ${PYTHON}
	__EOF__

	default
}

src_install() {
	default

	# yosys-smtbmc and yosys-witness keep an env python3 shebang that also
	# breaks under python-exec[-native-symlinks]; retarget them at EPYTHON.
	python_fix_shebang "${ED}"/usr/bin/yosys-smtbmc "${ED}"/usr/bin/yosys-witness
}
