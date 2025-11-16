# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

COMMIT="c7dea1f3ff1aefa62d30dba0e5c57e1322026ee3"
I2PD_COMMIT="2716869af40616a5585adf8894ce59bd92f128d1" # keep in sync with bundled version
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
		autoconf
	)

	for bin in "${binaries[@]}"; do
		newbin "${bin}" "i2pd-${bin}"
	done

	einstalldocs
}

pkg_postinst() {
	elog "All binaries are prefixed with 'i2pd-' to avoid file collisions,"
	elog "e.g. 'vain' becomes 'i2pd-vain'."
}
