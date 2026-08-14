# Copyright 2021-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1

DESCRIPTION="A Nintendo HID kernel module"
HOMEPAGE="https://github.com/nicman23/dkms-hid-nintendo https://github.com/DanielOgorchock/linux"
EGIT_REPO_URI="https://github.com/nicman23/dkms-hid-nintendo"

LICENSE="GPL-2"
SLOT="0"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/nicman23/dkms-hid-nintendo"
else
	MY_COMMIT="2712136b19eed75bff01c1a6ffe2a23daf78a7bb"
	SRC_URI="https://github.com/nicman23/dkms-hid-nintendo/archive/${MY_COMMIT}.tar.gz -> ${P}.gh.tar.gz"
	S="${WORKDIR}/dkms-hid-nintendo-${MY_COMMIT}"
	KEYWORDS="~amd64"
fi

CONFIG_CHECK="~HID ~HID_GENERIC ~USB_HID ~HIDRAW ~UHID"

src_prepare() {
	default
	if kernel_is -ge 6 12; then
		# header was moved in 6.12
		sed -i 's|<asm/unaligned.h>|<linux/unaligned.h>|' src/hid-nintendo.c || die
	fi
}

src_compile() {
	local modlist=( src/hid-nintendo="${S}/src" )
	local modargs=( -C "${KV_DIR}" M="${S}/src" )

	linux-mod-r1_src_compile
}
