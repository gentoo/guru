# Copyright 2021-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 linux-mod-r1

DESCRIPTION="A Nintendo HID kernel module"
HOMEPAGE="https://github.com/nicman23/dkms-hid-nintendo https://github.com/DanielOgorchock/linux"
EGIT_REPO_URI="https://github.com/nicman23/dkms-hid-nintendo"

LICENSE="GPL-2"
SLOT="0"

CONFIG_CHECK="~HID ~HID_GENERIC ~USB_HID ~HIDRAW ~UHID"

src_compile() {
	local -a emakeargs=( "${MODULES_MAKEARGS[@]}" )
	emake -C "${KV_OUT_DIR}" M="${S}/src" "${emakeargs[@]}" modules
}

src_install() {
	local -a emakeargs=(
		"${MODULES_MAKEARGS[@]}"
		INSTALL_MOD_PATH="${ED}"
		INSTALL_MOD_DIR=kernel/drivers/hid
	)
	emake -C "${KV_OUT_DIR}" M="${S}/src" "${emakeargs[@]}" modules_install
	modules_post_process
}
