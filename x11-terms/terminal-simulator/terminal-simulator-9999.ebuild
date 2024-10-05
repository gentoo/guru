# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="VT100 and VT52 terminal hardware simulator"
HOMEPAGE="https://github.com/larsbrinkhoff/terminal-simulator"
EGIT_REPO_URI="https://github.com/larsbrinkhoff/terminal-simulator.git"

LICENSE="GPL-3"
SLOT="0"

DEPEND="media-libs/libsdl2 media-libs/sdl2-image virtual/opengl"
RDEPEND="${DEPEND}"

src_compile() {
	cd vt100
	emake
	cd ../vt52
	emake
}

src_install() {
	exeinto "/usr/libexec/terminal-simulator"
	doexe vt100/vt100
	doexe vt52/vt52
	dobin "${FILESDIR}/vt100"
	dobin "${FILESDIR}/vt52"

	# These directories are cd'd into because
	# the program looks for a hardcoded relative dir,
	# and even then the behavior is inconsistent
	keepdir "/usr/share/terminal-simulator/vt100"
	keepdir "/usr/share/terminal-simulator/vt52"
	insinto "/usr/share/terminal-simulator/common"
	doins common/*.shader
	insinto "/usr/share/terminal-simulator/vt100"
	doins common/*.shader
	insinto "/usr/share/terminal-simulator/vt52"
	doins common/*.shader

	dodoc README.md
}
