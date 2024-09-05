# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="command line utility to communicate with ModBus slave (RTU or TCP) "
HOMEPAGE="https://github.com/epsilonrt/mbpoll"
SRC_URI="https://github.com/epsilonrt/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/libmodbus"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e 's/add_definitions(-O2)//' CMakeLists.txt
	sed -i -e 's/-O2 //' CMakeLists.txt

	cmake_src_prepare
}
