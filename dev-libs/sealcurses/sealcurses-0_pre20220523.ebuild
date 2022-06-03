# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

COMMIT="d64caa13bc06b68906bb0a5cc87f1896226b0918"
DESCRIPTION="SDL Emulation and Adaptation Layer for Curses"
HOMEPAGE="https://git.skyjake.fi/skyjake/sealcurses"
SRC_URI="https://git.skyjake.fi/skyjake/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-libs/tfdn:=
	sys-libs/ncurses:=
"
DEPEND="${RDEPEND}"

src_install() {
	cmake_src_install
	find "${ED}" -name libsealcurses.a -delete || die
}
