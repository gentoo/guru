# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Fast system information display utility with modular customizable features"
HOMEPAGE="https://github.com/Techoraye/metetch"
SRC_URI="https://github.com/Techoraye/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	net-misc/curl
	sys-libs/ncurses:=
"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

src_install() {
	cmake_src_install
	einstalldocs
}
