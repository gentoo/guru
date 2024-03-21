# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

COMMIT="04cad950ca949d1a437a5718b40d3d0b9e33ee0d"

DESCRIPTION="A recreation of the Fallout 3 terminal via a linux bash script!"
HOMEPAGE="https://github.com/fohtla/Fallout3Terminal"
SRC_URI="https://github.com/fohtla/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RDEPEND="
	app-shells/bash
	media-sound/sox
	sys-apps/pv
	x11-terms/cool-retro-term
"

S="${WORKDIR}/${PN}-${COMMIT}"

src_install() {
	dobin "${FILESDIR}/${PN}"
	exeinto "/usr/share/${PN}"
	doexe terminalscript
	rm -f terminalscript || die
	insinto "/usr/share/${PN}"
	doins -r .
}
