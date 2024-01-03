# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3 desktop xdg

DESCRIPTION="A free, open-source Monero wallet"
HOMEPAGE="https://featherwallet.org"
EGIT_REPO_URI="https://github.com/feather-wallet/feather.git"

# Feather is released under the terms of the BSD license, but it vendors
# code from Monero and Tor too.
LICENSE="BSD MIT"
SLOT="0"
IUSE="qrcode home tickers crowdfunding bounties reddit revuo calc exchange xmrig localmonero"

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
	qrcode? ( media-libs/zxing-cpp )
"
RDEPEND="
	${DEPEND}
	net-vpn/tor
	xmrig? ( net-misc/xmrig )
"
BDEPEND="
	virtual/pkgconfig
"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=Release
		-DBUILD_SHARED_LIBS=OFF
		-DARCH=x86-64
		-DBUILD_TAG="linux-x64"
		-DBUILD_64=ON
		-DSELF_CONTAINED=OFF
		-DWITH_PLUGIN_HOME=$(usex home)
		-DWITH_PLUGIN_TICKERS=$(usex tickers)
		-DWITH_PLUGIN_CROWDFUNDING=$(usex crowdfunding)
		-DWITH_PLUGIN_BOUNTIES=$(usex bounties)
		-DWITH_PLUGIN_REDDIT=$(usex reddit)
		-DWITH_PLUGIN_REVUO=$(usex revuo)
		-DWITH_PLUGIN_CALC=$(usex calc)
		-DWITH_PLUGIN_EXCHANGE=$(usex exchange)
		-DWITH_PLUGIN_LOCALMONERO=$(usex localmonero)
		-DWITH_PLUGIN_XMRIG=$(usex xmrig)
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
