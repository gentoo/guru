# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1

COMMIT="29ec3577e52a50f876440c81267f609575c5161e"
XONE_DRIVER_VERSION="201707-1cd6a87c-623f-4407-a52d-c31be49e925c_e19f60808bdcbfbd3c3df6be3e71ffc52e43261e"

DESCRIPTION="Linux kernel driver for Xbox One and Xbox Series X|S accessories"
HOMEPAGE="https://github.com/medusalix/xone"
SRC_URI="
	mirror+https://github.com/medusalix/xone/archive/${COMMIT}.tar.gz -> ${P}.tar.gz
	http://download.windowsupdate.com/c/msdownload/update/driver/drvs/${XONE_DRIVER_VERSION:0:4}/${XONE_DRIVER_VERSION:4:2}/${XONE_DRIVER_VERSION:7}.cab
		-> ${PN}-driver-${XONE_DRIVER_VERSION}.cab
"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="GPL-2+ MS-TOU"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="bindist mirror test"

BDEPEND="app-arch/cabextract"

CONFIG_CHECK="SND CFG80211 INPUT_FF_MEMLESS USB POWER_SUPPLY LEDS_CLASS HID"
MODULES_KERNEL_MIN=5.11
PATCHES=(
	"${FILESDIR}/${PN}-0.3_p20240425-kernel_6.11.patch"
	"${FILESDIR}/${PN}-0.3_p20240425-sysfs_pairing.patch"
)

src_unpack() {
	unpack ${P}.tar.gz

	cabextract -F FW_ACC_00U.bin -d "${S}" "${DISTDIR}/${PN}-driver-${XONE_DRIVER_VERSION}.cab" > /dev/null \
		|| die "Failed to unpack driver"
}

src_prepare() {
	cp "${FILESDIR}/Makefile" "${S}" || die
	default
}

src_compile() {
	local modlist=(
		xone-wired=kernel/drivers/input/joystick
		xone-dongle=kernel/drivers/input/joystick
		xone-gip=kernel/drivers/input/joystick
		xone-gip-gamepad=kernel/drivers/input/joystick
		xone-gip-headset=kernel/drivers/input/joystick
		xone-gip-chatpad=kernel/drivers/input/joystick
		xone-gip-madcatz-strat=kernel/drivers/input/joystick

	)

	linux-mod-r1_src_compile
}

src_install() {
	linux-mod-r1_src_install

	einfo "Installing module blacklist"
	insinto /etc/modprobe.d/
	newins "${S}"/install/modprobe.conf xone-blacklist.conf

	einfo "Installing Microsoft binary firmware"
	insinto /lib/firmware/
	newins "${S}"/FW_ACC_00U.bin xow_dongle.bin
}
