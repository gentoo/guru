# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

DESCRIPTION="A gopsutil-based command to display system usage info as text"
HOMEPAGE="https://github.com/nwg-piotr/gopsuinfo"
SRC_URI="https://github.com/nwg-piotr/gopsuinfo/archive/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://github.com/ingenarel/guru-depfiles/releases/download/${P}-deps.tar.xz/${P}-deps.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=">=dev-lang/go-1.20"

src_compile() {
	emake build
}

src_install() {
	insinto /usr/share/gopsuinfo
	doins -r icons_light
	doins -r icons_dark
	dobin bin/gopsuinfo
}
