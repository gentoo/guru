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

src_prepare() {
	default

	# Fix execute permissions and add shebang for Python scripts
	local script
	while IFS= read -r -d '' script; do
		chmod +x "${script}" || die
		# Add shebang if missing
		if ! head -n 1 "${script}" | grep -q '^#!'; then
			sed -i '1i#!/usr/bin/env python3' "${script}" || die
		fi
	done < <(find . -name "*.py" -print0)

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
