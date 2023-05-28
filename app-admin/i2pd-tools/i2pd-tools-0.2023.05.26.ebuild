# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

COMMIT="40d335a4279aec7f227209831d79a4d8304111a2"
I2PD_COMMIT="a6bd8275ca496c75c84d7eb890c0071569d28f55" # keep in sync with bundled version
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

DEPEND="
	dev-libs/boost:=
	dev-libs/openssl:=
	sys-libs/zlib:=
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}"/${PN}-0.2023.03.12-nodebug.patch
	"${FILESDIR}"/${PN}-0.2023.03.12-flags.patch
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
