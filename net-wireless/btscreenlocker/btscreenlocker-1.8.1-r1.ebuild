# Copyright 2024-2025 Brayan M. Salazar <this.brayan@proton.me>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Daemon to lock your screen when Bluetooth trusted devices go away."
HOMEPAGE="https://github.com/brookiestein/BtScreenLocker"
SRC_URI="https://github.com/brookiestein/BtScreenLocker/archive/refs/tags/${PV}.tar.gz -> BtScreenLocker-${PV}.tar.gz"
S="${WORKDIR}/BtScreenLocker-${PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-qt/qtconnectivity:6[bluetooth]
	dev-qt/qtbase:6[dbus,widgets]
	>=net-wireless/bluez-5.76:=
"
RDEPEND="${DEPEND}"
BDEPEND="
	>=dev-build/cmake-3.28
	dev-qt/qttools:6[linguist]
	virtual/pkgconfig
"

src_prepare() {
	cmake_src_prepare
	# drop Qt5 support
	sed -i '/Qt5/d' CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs=(
		-DQT_VERSION_MAJOR=6
	)
	cmake_src_configure
}
