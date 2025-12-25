# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Fast system information display utility with modular customizable features"
HOMEPAGE="https://github.com/techoraye/metetch"
SRC_URI="https://github.com/techoraye/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	net-misc/curl
	sys-libs/ncurses:=
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_configure() {
	cmake_src_configure
}

src_install() {
	cmake_src_install
	einstalldocs
}