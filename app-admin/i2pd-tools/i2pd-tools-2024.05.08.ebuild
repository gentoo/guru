# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

COMMIT="d7a079ad644be3e55d2f7c5074a732166ffec19f"
I2PD_COMMIT="c98926abf2dcd3cbe2cbbfc00a9e9159240c3df9" # keep in sync with bundled version
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
	sys-libs/zlib:=
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}"/${PN}-0.2023.03.12-nodebug.patch
)

src_unpack() {
	default

	rmdir "${S}/i2pd" || die
	mv "${WORKDIR}"/i2pd-${I2PD_COMMIT} "${S}"/i2pd || die
}

src_configure() {
	tc-export AR CXX
}

src_compile() {
	mymakeflags=(
		CXXFLAGS="${CXXFLAGS}"
		LDFLAGS="${LDFLAGS}"
		USE_AESNI="$(usex cpu_flags_x86_aes)"
	)

	emake "${mymakeflags[@]}"
}

src_install() {
	local -a binaries

	# extracted from Makefile
	binaries=(
		vain keygen keyinfo famtool routerinfo regaddr regaddr_3ld
		i2pbase64 offlinekeys b33address regaddralias x25519 verifyhost
	)
	dobin "${binaries[@]}"

	einstalldocs
}
