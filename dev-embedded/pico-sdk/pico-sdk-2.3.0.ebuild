# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Libraries and tools for C/C++ development on RP2040 and RP2350 microcontrollers"
HOMEPAGE="https://github.com/raspberrypi/pico-sdk"

SRC_URI="
	https://github.com/raspberrypi/pico-sdk/releases/download/${PV}/${P}.tar.gz

	https://github.com/bluekitchen/btstack/archive/refs/tags/v1.8.2.tar.gz
		-> btstack-1.8.2.tar.gz

	https://github.com/georgerobotics/cyw43-driver/archive/refs/tags/v1.1.1.tar.gz
		-> cyw43-driver-1.1.1.tar.gz

	https://github.com/lwip-tcpip/lwip/archive/refs/tags/STABLE-2_2_1_RELEASE.tar.gz
		-> lwip-STABLE-2_2_1_RELEASE.tar.gz

	https://github.com/Mbed-TLS/mbedtls/archive/refs/tags/mbedtls-3.6.6.tar.gz

	https://github.com/hathach/tinyusb/archive/refs/tags/0.18.0.tar.gz
		-> tinyusb-0.18.0.tar.gz
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

src_prepare() {
	default

	cp -r "${WORKDIR}"/btstack-1.8.2/. "${S}/lib/btstack" || die
	cp -r "${WORKDIR}"/cyw43-driver-1.1.1/. "${S}/lib/cyw43-driver" || die
	cp -r "${WORKDIR}"/lwip-STABLE-2_2_1_RELEASE/. "${S}/lib/lwip" || die
	cp -r "${WORKDIR}"/mbedtls-mbedtls-3.6.6/. "${S}/lib/mbedtls" || die
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
