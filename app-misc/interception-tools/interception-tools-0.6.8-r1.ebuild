# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_BUILD_TYPE=Release

inherit cmake systemd

DESCRIPTION="A minimal composable infrastructure on top of libudev and libevdev"
HOMEPAGE="https://gitlab.com/interception/linux/tools"
SRC_URI="https://gitlab.com/interception/linux/tools/-/archive/v${PV}/tools-v${PV}.tar.bz2"

S="${WORKDIR}/tools-v${PV}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-cpp/yaml-cpp
	dev-libs/libevdev
	sys-libs/glibc
	virtual/libudev
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-build/cmake
	dev-libs/boost
"

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	cmake_src_configure
}

src_install() {
	cmake_src_install
	systemd_dounit "udevmon.service"
	newinitd "udevmon.init" "udevmon"
	keepdir /etc/interception
	keepdir /etc/interception/udevmon.d
}
