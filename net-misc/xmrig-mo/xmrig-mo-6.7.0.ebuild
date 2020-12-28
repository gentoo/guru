# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake optfeature

MO_PV="mo1"
DESCRIPTION="RandomX, CryptoNight, KawPow, AstroBWT and Argon2 miner for the MoneroOcean pool"
HOMEPAGE="https://moneroocean.stream/ https://github.com/MoneroOcean/xmrig"
SRC_URI="https://github.com/MoneroOcean/xmrig/archive/v${PV}-${MO_PV}.tar.gz -> ${P}-${MO_PV}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="libressl +ssl"

DEPEND="
	dev-libs/libuv:=
	sys-apps/hwloc:=
	ssl? (
		!libressl? ( dev-libs/openssl:= )
		libressl? ( dev-libs/libressl:= )
	)
"

S="${WORKDIR}/xmrig-${PV}-${MO_PV}"

src_prepare() {
	cmake_src_prepare
	sed -i '/notls/d' cmake/OpenSSL.cmake || die
	sed -i 's/1;/0;/g' src/donate.h || die
}

src_configure() {
	local mycmakeargs=(
		# TODO: Create expanded USE flag for all of the PoW algos.
		-DWITH_TLS=$(usex ssl)
		# TODO: opencl USE flag.
		-DWITH_OPENCL=OFF
		# TODO: cuda USE flag.
		-DWITH_CUDA=OFF
	)

	cmake_src_configure
}

src_install() {
	newbin "${BUILD_DIR}/xmrig" xmrig-mo
	dodoc -r doc/*.md
	einstalldocs
}

pkg_postinst() {
	elog "Increase the vm.nr_hugepages sysctl value so that XMRig can allocate with huge pages."
	elog "XMRig-MoneroOcean has been installed as /usr/bin/xmrig-mo"
	elog "in order to differentiate between the original XMRig"
	optfeature "CPU specific performance tweaks" sys-apps/msr-tools
}
