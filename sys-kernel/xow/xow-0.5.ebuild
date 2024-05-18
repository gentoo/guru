# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Linux driver for the Xbox One wireless dongle"
HOMEPAGE="https://github.com/medusalix/xow"
SRC_URI="https://github.com/medusalix/xow/archive/v${PV}.tar.gz -> ${P}.tar.gz
	http://download.windowsupdate.com/c/msdownload/update/driver/drvs/2017/07/1cd6a87c-623f-4407-a52d-c31be49e925c_e19f60808bdcbfbd3c3df6be3e71ffc52e43261e.cab -> xow-firmware.cab"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="virtual/libusb:1"
RDEPEND="${DEPEND}"
BDEPEND="app-arch/cabextract"

QA_EXECSTACK="bin/xow"

src_prepare() {
	cp "${DISTDIR}"/xow-firmware.cab "${S}"/driver.cab
	sed -i '/curl/d' "${S}"/Makefile || die
	sed -i 's#/etc/udev/rules.d#/lib/udev/rules.d#g' Makefile || die

	default
}

src_compile() {
	emake BUILD=RELEASE
}

src_install() {
	emake DESTDIR="${D}" PREFIX="" install
}
