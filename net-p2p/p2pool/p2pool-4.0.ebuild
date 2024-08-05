# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

#TODO: enable/fix GRPC dependency and add it as USE flag (https://github.com/SChernykh/p2pool/issues/313)

EAPI=8

inherit cmake verify-sig

DESCRIPTION="Decentralized pool for Monero mining"
HOMEPAGE="https://p2pool.io"
SRC_URI="
	https://github.com/SChernykh/p2pool/releases/download/v${PV}/p2pool_source.tar.xz -> ${P}.tar.xz
	verify-sig? ( https://github.com/SChernykh/p2pool/releases/download/v${PV}/sha256sums.txt.asc -> ${P}_shasums.asc )
"

LICENSE="BSD GPL-3+ ISC LGPL-3+ MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

DEPEND="
	dev-libs/libsodium
	net-libs/czmq
"
BDEPEND="
	verify-sig? ( sec-keys/openpgp-keys-schernykh )
"

src_unpack() {
	if use verify-sig; then
		local VERIFY_SIG_OPENPGP_KEY_PATH="${BROOT}"/usr/share/openpgp-keys/SChernykh.asc
		pushd "${DISTDIR}" > /dev/null || die
		verify-sig_verify_message ${P}_shasums.asc - | \
			tr \\r \\n | \
			tr '[:upper:]' '[:lower:]' | \
			sed -n '/p2pool_source/,$p' | \
			grep -m 1 sha256: | \
			sed "s/sha256: \(.*\)/\1 ${P}.tar.xz/" | \
			verify-sig_verify_unsigned_checksums - sha256 ${P}.tar.xz
		assert
		popd || die
	fi
	unpack ${P}.tar.xz
	mv -T "${WORKDIR}"/${PN} "${WORKDIR}"/${P} || die
}

src_configure() {
	local mycmakeargs=(
		-DWITH_RANDOMX=OFF
		-DWITH_GRPC=OFF
	)

	cmake_src_configure
}

src_install(){
	dobin "${BUILD_DIR}/p2pool"
}

pkg_postinst() {
	#Some important wisdom taken from P2Pool documentation
	ewarn "P2Pool for Monero is now installed."
	ewarn "You can run it by doing 'p2pool --host 127.0.0.1 --wallet YOUR_PRIMARY_ADDRESS'"
	ewarn "Where 127.0.0.1 is the address of a local monero node (e.g. monerod)"
	ewarn ""
	ewarn "Once configured, point your RandomX miner (e.g. XMRig) at p2pool"
	ewarn "For example 'xmrig -o 127.0.0.1:3333'"
	ewarn ""
	ewarn "You MUST use your primary address when using p2pool, just like solo mining."
	ewarn "If you want privacy, create a new mainnet wallet for P2Pool mining."
	ewarn ""
	ewarn "Rewards will not be visible unless you use a wallet that supports P2Pool."
	ewarn "See https://p2pool.io/#help and https://github.com/SChernykh/p2pool for more information."
}
