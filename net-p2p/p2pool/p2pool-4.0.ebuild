# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

#TODO: verify hell script is safe
#TODO: enable/fix GRPC dependency and add it as USE flag (https://github.com/SChernykh/p2pool/issues/313)

EAPI=8

inherit cmake verify-sig

DESCRIPTION="Decentralized pool for Monero mining"
HOMEPAGE="https://p2pool.io"
SRC_URI="
	https://github.com/SChernykh/p2pool/releases/download/v${PV}/p2pool_source.tar.xz -> ${P}_source.tar.xz
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

VERIFY_SIG_OPENPGP_KEY_PATH="${BROOT}"/usr/share/openpgp-keys/SChernykh.asc

src_unpack() {
	if use verify-sig; then
		#what we want to do is `verify-sig_verify_signed_checksums ${P}_shasums.asc sha512 p2pool_source.tar.xz`
		verify-sig_verify_message "${DISTDIR}/${P}_shasums.asc" "${WORKDIR}/p2pool_shasums.txt"
		
		#start of hell script
		hellscript_stage=0
		tr -d '\r' < p2pool_shasums.txt | while IFS='' read -r LINE; do
			if [ "$hellscript_stage" -eq 0 ] && [ "$LINE" = "Name: p2pool_source.tar.xz" ]; then
				hellscript_stage=1
				continue
			fi
			if [ "$hellscript_stage" -eq 1 ]; then
				hellscript_sizestring="Size: $(cat ${DISTDIR}/${P}_source.tar.xz | wc -c) bytes"
				if [ "${LINE:0:"${#hellscript_sizestring}"}" = "$hellscript_sizestring" ]; then
					hellscript_stage=2
					continue
				else
					die
				fi
			fi
			if [ "$hellscript_stage" -eq 2 ]; then
				hellscript_shaprefix="SHA256: "
				if [ "${LINE:0:"${#hellscript_shaprefix}"}" = "$hellscript_shaprefix" ]; then
					echo "$(echo "${LINE:"${#hellscript_shaprefix}"}" | tr '[:upper:]' '[:lower:]')  ${DISTDIR}/${P}_source.tar.xz" \
					 > "${WORKDIR}/src_shasum.txt"
				else
					die
				fi
				break
			fi
		done
		verify-sig_verify_unsigned_checksums "${WORKDIR}/src_shasum.txt" sha256 "${DISTDIR}/${P}_source.tar.xz"
		#end of hell script
	fi
	unpack ${P}_source.tar.xz
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
