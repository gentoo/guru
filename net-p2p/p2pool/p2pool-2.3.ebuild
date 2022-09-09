# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

P2POOL_DIST_COMMIT="d40bb61da88ac25b8d92ca37c006d0d7e8ec8550"
	RANDOMX_DIST_COMMIT="b39068f7c3086f7453a80b7a444d3651b0684500"
	CPPZMQ_DIST_COMMIT="e70dd63a343e79315ff3950246a6f0d20b018944"
	CURL_DIST_COMMIT="e5926fe5f91ae5673c7d5e31e484aed4188581f7"
	LIBUV_DIST_COMMIT="0c1fa696aa502eb749c2c4735005f41ba00a27b8"
	LIBZMQ_DIST_COMMIT="4e193f36fc7d0f729a7c87d55fff18d8c0db5ebf"
	RAPIDJSON_DIST_COMMIT="914b772dfda5301dfa94309a114b207c67720d68"
	ROBIN_HOOD_HASHING_DIST_COMMIT="7f87d77122d15f76519f2b03f5455df98758e764"

DESCRIPTION="Decentralized pool for Monero mining"
HOMEPAGE="https://p2pool.io https://github.com/SChernykh/p2pool"

SRC_URI="https://github.com/SChernykh/p2pool/archive/${P2POOL_DIST_COMMIT}.tar.gz -> ${P}.tar.gz
	https://github.com/tevador/RandomX/archive/${RANDOMX_DIST_COMMIT}.tar.gz -> ${PF}-randomx.tar.gz
	https://github.com/SChernykh/cppzmq/archive/${CPPZMQ_DIST_COMMIT}.tar.gz -> ${PF}-cppzmq.tar.gz
	https://github.com/SChernykh/curl/archive/${CURL_DIST_COMMIT}.tar.gz -> ${PF}-curl.tar.gz
	https://github.com/SChernykh/libuv/archive/${LIBUV_DIST_COMMIT}.tar.gz -> ${PF}-libuv.tar.gz
	https://github.com/SChernykh/libzmq/archive/${LIBZMQ_DIST_COMMIT}.tar.gz -> ${PF}-libzmq.tar.gz
	https://github.com/SChernykh/rapidjson/archive/${RAPIDJSON_DIST_COMMIT}.tar.gz -> ${PF}-rapidjson.tar.gz
	https://github.com/SChernykh/robin-hood-hashing/archive/${ROBIN_HOOD_HASHING_DIST_COMMIT}.tar.gz -> ${PF}-robin-hood-hashing.tar.gz
"
KEYWORDS="~amd64 ~arm64 ~x86"

LICENSE="BSD GPL-3+ ISC LGPL-3+ MIT"
SLOT="0"

DEPEND="
	dev-libs/libsodium
"

src_unpack() {
	unpack ${P}.tar.gz ${PF}-randomx.tar.gz ${PF}-cppzmq.tar.gz ${PF}-curl.tar.gz ${PF}-libuv.tar.gz ${PF}-libzmq.tar.gz ${PF}-rapidjson.tar.gz ${PF}-robin-hood-hashing.tar.gz
	#mv -T "${WORKDIR}"/p2pool-${P2POOL_DIST_COMMIT} "${WORKDIR}"/${PF}
	mv -T "${WORKDIR}"/RandomX-${RANDOMX_DIST_COMMIT} "${WORKDIR}"/${PF}/external/src/RandomX
	mv -T "${WORKDIR}"/cppzmq-${CPPZMQ_DIST_COMMIT} "${WORKDIR}"/${PF}/external/src/cppzmq
	mv -T "${WORKDIR}"/curl-${CURL_DIST_COMMIT} "${WORKDIR}"/${PF}/external/src/curl
	mv -T "${WORKDIR}"/libuv-${LIBUV_DIST_COMMIT} "${WORKDIR}"/${PF}/external/src/libuv
	mv -T "${WORKDIR}"/libzmq-${LIBZMQ_DIST_COMMIT} "${WORKDIR}"/${PF}/external/src/libzmq
	mv -T "${WORKDIR}"/rapidjson-${RAPIDJSON_DIST_COMMIT} "${WORKDIR}"/${PF}/external/src/rapidjson
	mv -T "${WORKDIR}"/robin-hood-hashing-${ROBIN_HOOD_HASHING_DIST_COMMIT} "${WORKDIR}"/${PF}/external/src/robin-hood-hashing
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
	ewarn "Rewards will not be visibile unless you use a wallet that supports P2Pool."
	ewarn "See https://p2pool.io/#help and https://github.com/SChernykh/p2pool for more information."
}
