# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="Decentralized pool for Monero mining"
HOMEPAGE="https://p2pool.io"
EGIT_REPO_URI="https://github.com/SChernykh/p2pool.git"

LICENSE="BSD GPL-3+ ISC LGPL-3+ MIT"
SLOT="0"

DEPEND="
	dev-libs/libsodium
	net-libs/czmq
"

src_prepare() {
	default

	# 884447: remove -s from OPTIMIZATION_FLAGS
	sed -i 's/-s\>//' cmake/flags.cmake || die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DWITH_RANDOMX=OFF
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
