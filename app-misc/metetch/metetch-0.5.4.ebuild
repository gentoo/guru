# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Fast system information display utility with modular customizable features"
HOMEPAGE="https://github.com/techoraye/metetch"
SRC_URI="https://github.com/techoraye/metetch/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	sys-libs/ncurses:=
	net-misc/curl
"
DEPEND="${RDEPEND}
	sys-libs/glibc
"
BDEPEND="
	virtual/pkgconfig
"

S="${WORKDIR}/${PN}-${PV}"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=Release
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	
	# Install license
	einstalldocs
	newdoc LICENSE LICENSE.MIT
}
