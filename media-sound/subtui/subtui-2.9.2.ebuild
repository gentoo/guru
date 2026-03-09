# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="A lightweight Subsonic TUI music player built in Go with scrobbling support."
HOMEPAGE="https://github.com/MattiaPun/SubTUI"
SRC_URI="https://github.com/MattiaPun/SubTUI/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://github.com/RealFX-Code/files/releases/download/a/${P}-deps.tar.xz -> ${P}-deps.tar.xz"

S="${WORKDIR}/SubTUI-${PV}"

LICENSE="MIT"
LICENSE+=" BSD"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="media-video/mpv"
RDEPEND="${DEPEND}"

src_compile() {
	ego build .
}

src_install() {
	dobin SubTUI
	dodoc README.md
}
