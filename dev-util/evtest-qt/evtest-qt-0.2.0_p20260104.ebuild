# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg cmake

DESCRIPTION="simple input device tester for Linux (using evdev)"
HOMEPAGE="https://github.com/Grumbel/evtest-qt/"

MY_PV="41343d3a9bc882a973bb50351d8ee041c7f30c96"
SRC_URI="https://github.com/Grumbel/evtest-qt/archive/${MY_PV}.tar.gz -> ${PN}-${MY_PV}.tar.gz"
S="${WORKDIR}/${PN}-${MY_PV}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-qt/qtbase:6
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-build/tinycmmc
"

src_prepare() {
	# Bump CMake version, it just works
	sed -e '/^cmake_minimum_required(/s/VERSION [^)]*/VERSION 4.0/' \
		-i CMakeLists.txt
	cmake_src_prepare
}
