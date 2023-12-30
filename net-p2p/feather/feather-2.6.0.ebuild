# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake desktop xdg

#Verify feather-${PV}.tar.gz with  https://github.com/feather-wallet/feather-sigs
SINGLEAPPLICATION_DIST_COMIT="3e8e85d1a487e433751711a8a090659684d42e3b"
MONERO_DIST_COMIT="34aacb1b49553f17b9bb7ca1ee6dfb6524aada55"
	MINIUPNP_DIST_COMIT="544e6fcc73c5ad9af48a8985c94f0f1d742ef2e0"
	RANDOMX_DIST_COMIT="261d58c77fc5547c0aa7fdfeb58421ba7e0e6e1c"
	RAPIDJSON_DIST_COMIT="129d19ba7f496df5e33658527a7158c79b99c21c"
	SUPERCOP_DIST_COMIT="633500ad8c8759995049ccd022107d1fa8a1bbc9"
	TREZORCOMMON_DIST_COMIT="bff7fdfe436c727982cc553bdfb29a9021b423b0"

DESCRIPTION="A free, open-source Monero wallet"
HOMEPAGE="https://featherwallet.org"
SRC_URI="https://github.com/feather-wallet/feather/archive/refs/tags/${PV}.tar.gz -> \
${PF}.tar.gz
	https://github.com/itay-grudev/SingleApplication/archive/${SINGLEAPPLICATION_DIST_COMIT}.tar.gz -> \
${PF}-singleapplication.tar.gz
	https://github.com/feather-wallet/monero/archive/${MONERO_DIST_COMIT}.tar.gz -> \
${PF}-monero.tar.gz
	https://github.com/miniupnp/miniupnp/archive/${MINIUPNP_DIST_COMIT}.tar.gz -> \
${PF}-monero-miniupnp.tar.gz
	https://github.com/tevador/RandomX/archive/${RANDOMX_DIST_COMIT}.tar.gz -> \
${PF}-monero-randomx.tar.gz
	https://github.com/Tencent/rapidjson/archive/${RAPIDJSON_DIST_COMIT}.tar.gz -> \
${PF}-monero-rapidjson.tar.gz
	https://github.com/monero-project/supercop/archive/${SUPERCOP_DIST_COMIT}.tar.gz -> \
${PF}-monero-supercop.tar.gz
	https://github.com/trezor/trezor-common/archive/${TREZORCOMMON_DIST_COMIT}.tar.gz -> \
${PF}-monero-trezorcommon.tar.gz
"

# Feather is released under the terms of the BSD license, but it vendors
# code from Monero and Tor too.
LICENSE="BSD MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="qrcode xmrig localmonero"

DEPEND="
	dev-libs/libsodium:=
	media-gfx/qrencode:=
	media-gfx/zbar:=[v4l]
	~dev-libs/polyseed-1.0.0
	dev-libs/libzip:=
	dev-libs/boost:=[nls]
	>=dev-qt/qtbase-6.5.2:6
	>=dev-qt/qtsvg-6.5.2:6
	>=dev-qt/qtmultimedia-6.5.2:6
	>=dev-qt/qtwebsockets-6.5.2:6
	dev-libs/libgcrypt:=
	sys-libs/zlib
	dev-libs/openssl:=
	net-dns/unbound:=[threads]
	net-libs/czmq:=
	dev-util/bc-ur:=
"
RDEPEND="
	${DEPEND}
	net-vpn/tor
	xmrig? ( net-misc/xmrig )
"
BDEPEND="virtual/pkgconfig"

src_unpack() {
	unpack ${PF}.tar.gz \
		${PF}-singleapplication.tar.gz \
		${PF}-monero.tar.gz \
		${PF}-monero-miniupnp.tar.gz \
		${PF}-monero-randomx.tar.gz \
		${PF}-monero-rapidjson.tar.gz \
		${PF}-monero-supercop.tar.gz \
		${PF}-monero-trezorcommon.tar.gz
	mv -T "${WORKDIR}"/SingleApplication-${SINGLEAPPLICATION_DIST_COMIT} \
		"${WORKDIR}"/${P}/src/third-party/singleapplication || die
	mv -T "${WORKDIR}"/monero-${MONERO_DIST_COMIT} \
		"${WORKDIR}"/${P}/monero || die
	mv -T "${WORKDIR}"/miniupnp-${MINIUPNP_DIST_COMIT} \
		"${WORKDIR}"/${P}/monero/external/miniupnp || die
	mv -T "${WORKDIR}"/RandomX-${RANDOMX_DIST_COMIT} \
		"${WORKDIR}"/${P}/monero/external/randomx || die
	mv -T "${WORKDIR}"/rapidjson-${RAPIDJSON_DIST_COMIT} \
		"${WORKDIR}"/${P}/monero/external/rapidjson || die
	mv -T "${WORKDIR}"/supercop-${SUPERCOP_DIST_COMIT} \
		"${WORKDIR}"/${P}/monero/external/supercop || die
	mv -T "${WORKDIR}"/trezor-common-${TREZORCOMMON_DIST_COMIT} \
		"${WORKDIR}"/${P}/monero/external/trezor-common || die
}

src_prepare() {
	default
	echo "#define FEATHER_VERSION \"${PV}\"" > "${WORKDIR}"/${P}/src/config-feather.h || die
	echo "#define TOR_VERSION \"NOT_EMBEDDED\"" >> "${WORKDIR}"/${P}/src/config-feather.h || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=Release
		-DBUILD_SHARED_LIBS=OFF
		-DARCH=x86-64
		-DBUILD_TAG="linux-x64"
		-DBUILD_64=ON
		-DSELF_CONTAINED=OFF
		#-DLOCALMONERO=$(usex localmonero)
		#-DXMRIG=$(usex xmrig)
		-DCHECK_UPDATES=OFF
		-DPLATFORM_INSTALLER=OFF
		-DUSE_DEVICE_TREZOR=OFF
		-DDONATE_BEG=OFF
		-DWITH_SCANNER=$(usex qrcode)
	)

	cmake_src_configure
}

src_compile() {
	cmake_build feather
}

src_install() {
	dobin "${BUILD_DIR}/bin/feather"

	newicon -s 256 "${WORKDIR}"/${P}/src/assets/images/appicons/256x256.png feather.png
	newicon -s 128 "${WORKDIR}"/${P}/src/assets/images/appicons/128x128.png feather.png
	newicon -s 96 "${WORKDIR}"/${P}/src/assets/images/appicons/96x96.png feather.png
	newicon -s 64 "${WORKDIR}"/${P}/src/assets/images/appicons/64x64.png feather.png
	newicon -s 48 "${WORKDIR}"/${P}/src/assets/images/appicons/48x48.png feather.png
	newicon -s 32 "${WORKDIR}"/${P}/src/assets/images/appicons/32x32.png feather.png
	domenu "${WORKDIR}"/${P}/src/assets/feather.desktop
}

pkg_postinst() {
	xdg_pkg_postinst

	einfo "Ensure that Tor is running with 'rc-service tor start' before"
	einfo "using Feather."
}
