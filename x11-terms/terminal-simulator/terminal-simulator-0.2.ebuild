# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="VT100 terminal hardware simulator"
HOMEPAGE="https://github.com/larsbrinkhoff/terminal-simulator"
SRC_URI="https://github.com/larsbrinkhoff/terminal-simulator/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="media-libs/libsdl2 media-libs/sdl2-image virtual/opengl"
RDEPEND="${DEPEND}"

src_compile() {
	cd vt100
	emake
}

src_install() {
	exeinto "/usr/libexec/terminal-simulator"
	doexe vt100/vt100
	dobin "${FILESDIR}/vt100"

	# This directoy is cd'd into because the
	# program looks for a hardcoded relative dir
	insinto "/usr/share/terminal-simulator/vt100"
	doins vt100/*.shader

	dodoc README.md
}
