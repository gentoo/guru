# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

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
	dev-libs/boost
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}/interception-tools-0.6.8-r2-cmake-version-3-10.patch"
)

src_install() {
	cmake_src_install
	systemd_dounit "udevmon.service"
	newinitd "udevmon.init" "udevmon"
	keepdir /etc/interception
	keepdir /etc/interception/udevmon.d
}
