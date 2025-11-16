# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

COMMIT="b483a59093460861f9a124eb8639268ace69d9cc"
I2PD_COMMIT="80080fd8f5df5c8c07df044458eedbf8fbbbe86c" # keep in sync with bundled version
DESCRIPTION="Some useful tools for I2P"
HOMEPAGE="https://github.com/PurpleI2P/i2pd-tools"
SRC_URI="
	https://github.com/PurpleI2P/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz
	https://github.com/PurpleI2P/i2pd/archive/${I2PD_COMMIT}.tar.gz -> i2pd-${I2PD_COMMIT:0:7}.tar.gz
"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="cpu_flags_x86_aes"

DEPEND="
	dev-libs/boost:=
	dev-libs/openssl:=
	virtual/zlib:=
"
RDEPEND="${DEPEND}"

src_unpack() {
	default

	rmdir "${S}/i2pd" || die
	mv "${WORKDIR}"/i2pd-${I2PD_COMMIT} "${S}"/i2pd || die
}

src_configure() {
	local mycmakeargs=(
		-DWITH_LIBRARY=OFF
		-DWITH_BINARY=OFF
		-DCMAKE_SKIP_RPATH=ON
	)
	cmake_src_configure
}

src_install() {
	local -a binaries

	# extracted from Makefile
	mv "${BUILD_DIR}"/{autoconf_i2pd,autoconf} || die
	binaries=(
		vain keygen keyinfo famtool routerinfo regaddr regaddr_3ld
		i2pbase64 offlinekeys b33address regaddralias x25519 verifyhost
		autoconf
	)

	for bin in "${binaries[@]}"; do
		newbin "${BUILD_DIR}/${bin}" "i2pd-${bin}"
	done

	einstalldocs
}

pkg_postinst() {
	elog "All binaries are prefixed with 'i2pd-' to avoid file collisions,"
	elog "e.g. 'vain' becomes 'i2pd-vain'."
}
