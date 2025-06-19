# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Libraries and tools for C/C++ development on RP2040 and RP2350 microcontrollers."
HOMEPAGE="https://github.com/raspberrypi/pico-sdk"

SRC_URI="
	https://github.com/raspberrypi/pico-sdk/releases/download/${PV}/${P}.tar.gz
		-> ${P}.tar.gz

	https://github.com/bluekitchen/btstack/archive/501e6d2b86e6c92bfb9c390bcf55709938e25ac1.tar.gz
		-> btstack-501e6d2b86e6c92bfb9c390bcf55709938e25ac1.tar.gz

	https://github.com/georgerobotics/cyw43-driver/archive/c1075d4bc440422cf2b2fd12c64a1f53f77660ee.tar.gz
		-> cyw43-driver-c1075d4bc440422cf2b2fd12c64a1f53f77660ee.tar.gz

	https://github.com/lwip-tcpip/lwip/archive/refs/tags/STABLE-2_2_0_RELEASE.tar.gz
		-> lwip-STABLE-2_2_0_RELEASE.tar.gz

	https://github.com/Mbed-TLS/mbedtls/releases/download/v2.28.8/mbedtls-2.28.8.tar.bz2
		-> mbedtls-2.28.8.tar.bz2

	https://github.com/hathach/tinyusb/archive/refs/tags/0.18.0.tar.gz
		-> tinyusb-0.18.0.tar.gz
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

src_prepare() {
	default

	cp -r "${WORKDIR}"/btstack-501e6d2b86e6c92bfb9c390bcf55709938e25ac1/. "${S}/lib/btstack" || die
	cp -r "${WORKDIR}"/cyw43-driver-c1075d4bc440422cf2b2fd12c64a1f53f77660ee/. "${S}/lib/cyw43-driver" || die
	cp -r "${WORKDIR}"/lwip-STABLE-2_2_0_RELEASE/. "${S}/lib/lwip" || die
	cp -r "${WORKDIR}"/mbedtls-2.28.8/. "${S}/lib/mbedtls" || die
	cp -r "${WORKDIR}"/tinyusb-0.18.0/. "${S}/lib/tinyusb" || die
}

src_install() {
	dodir /opt/pico-sdk
	cp -r "${S}/." "${D}/opt/pico-sdk/" || die

	echo "PICO_SDK_PATH=/opt/pico-sdk" > "${T}/99pico-sdk" || die
	doenvd "${T}/99pico-sdk"
}

pkg_postinst() {
	elog "If you want to use the Pico SDK now, run:"
	elog "    source /etc/profile"
}
