# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1

DESCRIPTION="Linux kernel driver for Xbox One and Xbox Series X|S accessories"
HOMEPAGE="https://github.com/dlundqvist/xone"
SRC_URI="
	mirror+https://github.com/dlundqvist/xone/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://catalog.s.download.windowsupdate.com/d/msdownload/update/driver/drvs/2017/03/2ea9591b-f751-442c-80ce-8f4692cdc67b_6b555a3a288153cf04aec6e03cba360afe2fce34.cab
		-> ${PN}-firmware-02fe.cab
	https://catalog.s.download.windowsupdate.com/c/msdownload/update/driver/drvs/2017/07/1cd6a87c-623f-4407-a52d-c31be49e925c_e19f60808bdcbfbd3c3df6be3e71ffc52e43261e.cab
		-> ${PN}-firmware-02e6.cab
	https://catalog.s.download.windowsupdate.com/c/msdownload/update/driver/drvs/2017/06/1dbd7cb4-53bc-4857-a5b0-5955c8acaf71_9081931e7d664429a93ffda0db41b7545b7ac257.cab
		-> ${PN}-firmware-02f9.cab
	https://catalog.s.download.windowsupdate.com/d/msdownload/update/driver/drvs/2017/08/aeff215c-3bc4-4d36-a3ea-e14bfa8fa9d2_e58550c4f74a27e51e5cb6868b10ff633fa77164.cab
		-> ${PN}-firmware-091e.cab
"

LICENSE="GPL-2+ MS-TOU"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="bindist mirror test"

BDEPEND="app-arch/cabextract"

CONFIG_CHECK="SND CFG80211 INPUT_FF_MEMLESS USB POWER_SUPPLY LEDS_CLASS HID SYSFS"
MODULES_KERNEL_MIN=6.5

src_unpack() {
	unpack ${P}.tar.gz

	cabextract -F FW_ACC_00U.bin -d "${S}/xone_firmware_02fe" \
		"${DISTDIR}/${PN}-firmware-02fe.cab" > /dev/null || die
	cabextract -F FW_ACC_00U.bin -d "${S}/xone_firmware_02e6" \
		"${DISTDIR}/${PN}-firmware-02e6.cab" > /dev/null || die
	cabextract -F FW_ACC_CL.bin -d "${S}/xone_firmware_02f9" \
		"${DISTDIR}/${PN}-firmware-02f9.cab" > /dev/null || die
	cabextract -F FW_ACC_BR.bin -d "${S}/xone_firmware_091e" \
		"${DISTDIR}/${PN}-firmware-091e.cab" > /dev/null || die
}

src_prepare() {
	cp "${FILESDIR}/Makefile" "${S}" || die
	default
}

src_compile() {
	local modlist=(
		xone_wired=kernel/drivers/input/joystick
		xone_dongle=kernel/drivers/input/joystick
		xone_gip=kernel/drivers/input/joystick
		xone_gip_gamepad=kernel/drivers/input/joystick
		xone_gip_headset=kernel/drivers/input/joystick
		xone_gip_chatpad=kernel/drivers/input/joystick
		xone_gip_madcatz_strat=kernel/drivers/input/joystick
		xone_gip_madcatz_glam=kernel/drivers/input/joystick
		xone_gip_pdp_jaguar=kernel/drivers/input/joystick

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
	newins "${S}"/xone_firmware_02e6/FW_ACC_00U.bin xone_dongle_02e6.bin
	newins "${S}"/xone_firmware_02fe/FW_ACC_00U.bin xone_dongle_02fe.bin
	newins "${S}"/xone_firmware_02f9/FW_ACC_CL.bin xone_dongle_02f9.bin
	newins "${S}"/xone_firmware_091e/FW_ACC_BR.bin xone_dongle_091e.bin
}
