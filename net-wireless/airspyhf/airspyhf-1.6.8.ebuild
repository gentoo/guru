# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake udev

DESCRIPTION="User mode driver for Airspy HF+"
HOMEPAGE="https://airspy.com/airspy-hf-plus/"
SRC_URI="https://github.com/airspy/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

IUSE="udevrules"

DEPEND="dev-libs/libusb"

RDEPEND="${DEPEND}"

BDEPEND="virtual/pkgconfig"

src_prepare(){
	sed -i "s@DESTINATION \"/etc/udev/rules.d\"@DESTINATION \"$(get_udevdir)/rules.d\"@" "tools/CMakeLists.txt" || die

	cmake_src_prepare
}

src_configure(){
	mycmakeargs+=(
		-DINSTALL_UDEV_RULES=$(usex udevrules)
	)
	cmake_src_configure
}

pkg_postinst(){
	udev_reload
}

pkg_postrm(){
	udev_reload
}
