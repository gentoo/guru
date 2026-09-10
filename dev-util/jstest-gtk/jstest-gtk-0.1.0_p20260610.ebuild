# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg cmake

DESCRIPTION="joystick testing and configuration tool (old joydev interface)"
HOMEPAGE="https://github.com/Grumbel/jstest-gtk/"

MY_PV="45d23082452d0838ad7dd124adacf28ca5c7ce4b"
SRC_URI="https://github.com/Grumbel/jstest-gtk/archive/${MY_PV}.tar.gz -> ${PN}-${MY_PV}.tar.gz"
S="${WORKDIR}/${PN}-${MY_PV}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-cpp/gtkmm:3.0
	dev-libs/libsigc++:2
	virtual/udev
	x11-libs/libX11
"
DEPEND="${RDEPEND}"

src_prepare() {
	# Bump CMake version, it just works
	sed -e '/^cmake_minimum_required(/s/VERSION [^)]*/VERSION 4.0/' \
		-i CMakeLists.txt
	cmake_src_prepare
}
