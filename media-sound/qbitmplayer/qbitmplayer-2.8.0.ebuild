# Copyright 2024-2025 Brayan M. Salazar <this.brayan@proton.me>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Music Player written in C++ & Qt."
HOMEPAGE="https://github.com/brookiestein/QBitMPlayer"
SRC_URI="https://github.com/brookiestein/QBitMPlayer/archive/refs/tags/${PV}.tar.gz -> QBitMPlayer-${PV}.tar.gz"
S="${WORKDIR}/QBitMPlayer-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="dbus"

DEPEND="
	dev-qt/qtmultimedia:6
	dev-qt/qtbase:6[widgets]
	dbus? ( dev-qt/qtbase:6[dbus] )
"
RDEPEND="${DEPEND}"
BDEPEND="
	>=dev-build/cmake-3.28
	dev-qt/qttools:6[linguist]
	virtual/pkgconfig
"

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DQT_VERSION_MAJOR=6
	)

	if use dbus; then
		mycmakeargs+=(
		-DUSE_IPC=1
	)
	fi

	cmake_src_configure
}
