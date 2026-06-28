# Copyright 2021-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

COMMIT="35c2e0332301f7aa14d3a849b30a844d65fa81bd"
DESCRIPTION="SDL Emulation and Adaptation Layer for Curses"
HOMEPAGE="https://git.skyjake.fi/skyjake/sealcurses"
SRC_URI="https://codeberg.org/skyjake/${PN}/archive/${COMMIT}.tar.gz -> ${P}.codeberg.tar.gz"
S="${WORKDIR}/${PN}"

LICENSE="BSD-2"
SLOT="0/$(ver_cut 1-2)"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="
	dev-libs/tfdn:=
	sys-libs/ncurses:=
"
DEPEND="${RDEPEND}"

src_configure() {
	local -a mycmakeargs=(
		-DSEALCURSES_ENABLE_STATIC=OFF
	)

	append-cppflags $(usex debug "-UNDEBUG" "-DNDEBUG")
	cmake_src_configure
}
