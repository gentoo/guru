# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Library to interface with USB Type-c/Power Delivery devices"
HOMEPAGE="https://github.com/Rajaram-Regupathy/libtypec"
SRC_URI="https://github.com/Rajaram-Regupathy/libtypec/releases/download/${P}/${P}-Source.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/${P}-Source"

PATCHES=(
	"${FILESDIR}/${PN}-0.5.0-CMakeLists.txt-fix-pkgconfig-install-path.patch"
	"${FILESDIR}/${PN}-0.5.0-sysfs_ops-define-feature-test-macro-for-nft.patch"
	"${FILESDIR}/${PN}-0.5.0-sysfs_ops-fix-nftw-fun-pointer-def.patch"
)

src_configure() {
	# don't force CFLAGS to allow Gentoo toolchain to set them
	local mycmakeargs=(
		-DLIBTYPEC_STRICT_CFLAGS=OFF
	)
	cmake_src_configure
}
