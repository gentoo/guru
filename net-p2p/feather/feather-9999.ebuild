# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3 desktop xdg

DESCRIPTION="A free, open-source Monero wallet"
HOMEPAGE="https://featherwallet.org"
SRC_URI=""
EGIT_REPO_URI="https://github.com/feather-wallet/feather.git"

# Feather is released under the terms of the BSD license, but it vendors
# code from Monero and Tor too.
LICENSE="BSD MIT"
SLOT="0"
KEYWORDS=""
IUSE="qrcode xmrig localmonero"

DEPEND="
	dev-libs/libsodium:=
	media-gfx/qrencode:=
	media-gfx/zbar:=[v4l]
	>=dev-libs/polyseed-1.0.0
	dev-libs/libzip:=
	dev-libs/boost:=[nls]
	>=dev-qt/qtcore-5.15:5
	>=dev-qt/qtwidgets-5.15:5
	>=dev-qt/qtgui-5.15:5
	>=dev-qt/qtnetwork-5.15:5
	>=dev-qt/qtsvg-5.15:5
	>=dev-qt/qtxml-5.15:5
	>=dev-qt/qtwebsockets-5.15:5
	>=dev-qt/qtmultimedia-5.15:5[widgets]
	>=dev-qt/qtconcurrent-5.15:5
	dev-libs/libgcrypt:=
	sys-libs/zlib
	dev-libs/openssl:=
	net-dns/unbound:=[threads]
	net-libs/czmq:=
"
RDEPEND="
	${DEPEND}	
	xmrig? ( net-misc/xmrig )
"
BDEPEND="virtual/pkgconfig"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=Release
		-DBUILD_SHARED_LIBS=OFF
		-DARCH=x86-64
		-DBUILD_TAG="linux-x64"
		-DBUILD_64=ON
		-DSELF_CONTAINED=OFF
		-DLOCALMONERO=$(usex localmonero)
		-DXMRIG=$(usex xmrig)
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

	doicon "${WORKDIR}"/${PF}/src/assets/images/feather.png
	domenu "${WORKDIR}"/${PF}/src/assets/feather.desktop
}

pkg_postinst() {
	xdg_pkg_postinst
}
