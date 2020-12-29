# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake systemd

MY_RANDOMX_REV="5ce5f4906c1eb166be980f6d83cc80f4112ffc2a"
MY_SUPERCOP_REV="633500ad8c8759995049ccd022107d1fa8a1bbc9"

DESCRIPTION="The secure, private, untraceable cryptocurrency"
HOMEPAGE="https://github.com/monero-project/monero"
SRC_URI="
	https://github.com/monero-project/monero/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/tevador/RandomX/archive/${MY_RANDOMX_REV}.tar.gz -> ${PN}-randomx-${PV}.tar.gz
	https://github.com/monero-project/supercop/archive/${MY_SUPERCOP_REV}.tar.gz -> ${PN}-supercop-${PV}.tar.gz
"

LICENSE="BSD MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="+daemon libressl readline tools +wallet-cli +wallet-rpc"
REQUIRED_USE="|| ( daemon tools wallet-cli wallet-rpc )"

DEPEND="
	acct-group/monero
	acct-user/monero
	dev-libs/boost:=[nls,threads]
	dev-libs/libsodium:=
	dev-libs/rapidjson
	net-dns/unbound:=[threads]
	net-libs/czmq:=
	net-libs/miniupnpc
	!libressl? ( dev-libs/openssl:= )
	libressl? ( dev-libs/libressl:= )
	readline? ( sys-libs/readline:0= )
"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

PATCHES=("${FILESDIR}/${P}-linkjobs.patch")

src_unpack() {
	unpack ${A}
	rmdir "${S}"/external/{randomx,supercop,trezor-common} || die
	mv "${WORKDIR}"/RandomX-${MY_RANDOMX_REV} "${S}"/external/randomx || die
	mv "${WORKDIR}"/supercop-${MY_SUPERCOP_REV} "${S}"/external/supercop || die
}

src_prepare() {
	cmake_src_prepare

	sed -i 's:miniupnp/::' src/p2p/net_node.inl || die
	sed -e 's/UPNP_LIBRARIES "libminiupnpc-static/UPNP_LIBRARIES "miniupnpc'/ \
		-e '/libminiupnpc-static/d' \
		-e '/\/miniupnpc/d' \
		-i external/CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
		-DMANUAL_SUBMODULES=ON
		-DMONERO_PARALLEL_LINK_JOBS=1
		-DUSE_DEVICE_TREZOR=OFF
	)

	cmake_src_configure
}

src_compile() {
	local targets=()
	use daemon && targets+=(daemon)
	use tools && targets+=(blockchain_{ancestry,blackball,db,depth,export,import,prune,prune_known_spent_data,stats,usage})
	use wallet-cli && targets+=(simplewallet)
	use wallet-rpc && targets+=(wallet_rpc_server)
	cmake_build ${targets[@]}
}

src_install() {
	# Install all binaries.
	find "${BUILD_DIR}/bin/" -type f -executable -print0 |
		while IFS= read -r -d '' line; do
			dobin "$line"
		done

	if use daemon; then
		dodoc utils/conf/monerod.conf

		# data-dir
		keepdir /var/lib/monero
		fowners monero:monero /var/lib/monero
		fperms 0755 /var/lib/monero

		# log-file dir
		keepdir /var/log/monero
		fowners monero:monero /var/log/monero
		fperms 0755 /var/log/monero

		# /etc/monero/monerod.conf
		insinto /etc/monero
		doins "${FILESDIR}/monerod.conf"

		# OpenRC
		newconfd "${FILESDIR}/monerod.confd" monerod
		newinitd "${FILESDIR}/monerod.initd" monerod

		# systemd
		systemd_dounit "${FILESDIR}/monerod.service"
	fi
}

pkg_postinst() {
	if use daemon; then
		einfo "Start the Monero P2P daemon as a system service with"
		einfo "'rc-service monerod start'. Enable it at startup with"
		einfo "'rc-update add monerod default'."
		einfo
		einfo "Run monerod status as any user to get sync status and other stats."
		einfo
		einfo "The Monero blockchain can take up a lot of space (80 GiB) and is stored"
		einfo "in /var/lib/monero by default. You may want to enable pruning by adding"
		einfo "'prune-blockchain=1' to /etc/monero/monerod.conf to prune the blockchain"
		einfo "or move the data directory to another disk."
	fi
}
