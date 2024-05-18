# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake systemd

DESCRIPTION="The secure, private, untraceable cryptocurrency"
HOMEPAGE="https://github.com/monero-project/monero"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/monero-project/monero.git"
	EGIT_SUBMODULES=()
else
	SRC_URI="https://github.com/monero-project/monero/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~x86"
fi

LICENSE="BSD MIT"
SLOT="0"
IUSE="+daemon hw-wallet readline +tools +wallet-cli +wallet-rpc"
REQUIRED_USE="|| ( daemon tools wallet-cli wallet-rpc )"
RESTRICT="test"

DEPEND="
	acct-group/monero
	acct-user/monero
	dev-libs/boost:=[nls]
	dev-libs/libsodium:=
	dev-libs/openssl:=
	dev-libs/randomx
	dev-libs/rapidjson
	dev-libs/supercop
	net-dns/unbound:=[threads]
	net-libs/czmq:=
	net-libs/miniupnpc
	readline? ( sys-libs/readline:0= )
	hw-wallet? (
		dev-libs/hidapi
		dev-libs/protobuf:=
		virtual/libusb:1
	)
"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}/${PN}-0.18.1.2-unbundle-dependencies.patch"
)

src_configure() {
	local mycmakeargs=(
		# TODO: Update CMake to install built libraries (help wanted)
		-DBUILD_SHARED_LIBS=OFF
		-DMANUAL_SUBMODULES=ON
		-DUSE_DEVICE_TREZOR=$(usex hw-wallet ON OFF)
	)

	use elibc_musl && mycmakeargs+=( -DSTACK_TRACE=OFF )

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
	einstalldocs

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
		elog "Start the Monero P2P daemon as a system service with"
		elog "'rc-service monerod start'. Enable it at startup with"
		elog "'rc-update add monerod default'."
		elog
		elog "Run monerod status as any user to get sync status and other stats."
		elog
		elog "The Monero blockchain can take up a lot of space (200 GiB) and is stored"
		elog "in /var/lib/monero by default. You may want to enable pruning by adding"
		elog "'prune-blockchain=1' to /etc/monero/monerod.conf to prune the blockchain"
		elog "or move the data directory to another disk."
	fi
}
