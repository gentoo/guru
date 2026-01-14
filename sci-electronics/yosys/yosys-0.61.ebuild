# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

inherit python-any-r1

DESCRIPTION="framework for Verilog RTL synthesis"
HOMEPAGE="https://yosyshq.net/yosys/"
SRC_URI="
	https://github.com/YosysHQ/${PN}/releases/download/v${PV}/yosys.tar.gz -> ${P}.tar.gz
"
S="${WORKDIR}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="tcl"

RDEPEND="
	dev-libs/boost:=
	dev-libs/libffi:=
	llvm-core/clang:=
	media-gfx/xdot
	sys-libs/ncurses:=
	sys-libs/readline:=
	virtual/zlib
	tcl? ( dev-lang/tcl:= )
"

DEPEND="${RDEPEND}"
BDEPEND="
	${PYTHON_DEPS}
	dev-vcs/git
	virtual/pkgconfig
"

src_configure() {
	cat <<-__EOF__ >> Makefile.conf || die
		PREFIX := ${EPREFIX}/usr
		STRIP := @echo "skipping strip"
		CXXFLAGS += ${CXXFLAGS}
		LINKFLAGS += ${LDFLAGS}
		PYTHON_EXECUTABLE := ${PYTHON}
	__EOF__

	if ! use tcl; then
		echo "ENABLE_TCL := 0" >> Makefile.conf || die
	fi

	default
}
