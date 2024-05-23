# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Library to interface with USB Type-c/Power Delivery devices"
HOMEPAGE="https://github.com/libtypec/libtypec"
SRC_URI="https://github.com/libtypec/libtypec/archive/refs/tags/${P}.tar.gz"

S="${WORKDIR}/${PN}-${P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_configure() {
	# don't force CFLAGS to allow Gentoo toolchain to set them
	local mycmakeargs=(
		-DLIBTYPEC_STRICT_CFLAGS=OFF
	)
	cmake_src_configure
}
