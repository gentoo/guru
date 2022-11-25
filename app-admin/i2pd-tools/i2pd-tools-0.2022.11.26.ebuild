# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

COMMIT="aadc780b44135d4b13f80b843d4c43810c2d7a7d"
I2PD_COMMIT="aead9db9712f8b07828a264a40898643385d7553" # keep in sync with bundled version
DESCRIPTION="Some useful tools for I2P"
HOMEPAGE="https://github.com/PurpleI2P/i2pd-tools"
SRC_URI="
	https://github.com/PurpleI2P/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz
	https://github.com/PurpleI2P/i2pd/archive/${I2PD_COMMIT}.tar.gz -> i2pd-${I2PD_COMMIT}.tar.gz
"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/boost:=
	dev-libs/openssl:=
	sys-libs/zlib:=
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}"/0001-${PN}-nodebug.patch
	"${FILESDIR}"/0002-${PN}-flags.patch
)

src_unpack() {
	default

	rmdir "${S}/i2pd" || die
	mv "${WORKDIR}"/i2pd-${I2PD_COMMIT} "${S}"/i2pd || die
}

src_configure() {
	tc-export CXX
}

src_install() {
	local -a binaries

	# extracted from Makefile
	binaries=(
		keygen keyinfo famtool routerinfo regaddr regaddr_3ld vain
		i2pbase64 offlinekeys b33address regaddralias x25519 verifyhost
	)
	dobin "${binaries[@]}"

	einstalldocs
}
