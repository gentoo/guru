# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1

DESCRIPTION="Realtek RTL8851BU USB Wi-Fi driver (out-of-tree kernel module)"
HOMEPAGE="https://github.com/fofajardo/rtl8851bu"

COMMIT="3e6c300f1117427572cb69d2eff8632535b2f86e"
SRC_URI="https://github.com/fofajardo/rtl8851bu/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

# Upstream claims support up to 6.13, but it is tested working on 6.18
MODULES_KERNEL_MAX="6.13"

# These are commonly required for mac80211 drivers.
CONFIG_CHECK="CFG80211 MAC80211"

# Kernel build tree is required to build external modules.
DEPEND="virtual/linux-sources"

DOCS=( README.md )

src_compile() {
	local modlist=( 8851bu )
	local modargs=(
		KVER="${KV_FULL}"
		KSRC="${KV_OUT_DIR}"
		KDIR="${KV_OUT_DIR}"
		KERNELDIR="${KV_OUT_DIR}"
	)

	linux-mod-r1_src_compile
}

src_install() {
	local modlist=( 8851bu )
	linux-mod-r1_src_install
}

pkg_postinst() {
	linux-mod-r1_pkg_postinst

	elog
	elog "If the adapter initially shows up as a 'Driver CD-ROM' device,"
	elog "install sys-apps/usb_modeswitch and replug it."
	elog
	elog "Known issue: this driver may operate in concurrent mode and create"
	elog "a second interface (often 'ap0'). If you use NetworkManager, mark it"
	elog "unmanaged to prevent crashes/disconnects. Example:"
	elog "  /etc/NetworkManager/NetworkManager.conf"
	elog "    [keyfile]"
	elog "    unmanaged-devices=interface-name:ap0"
	elog
	elog "Bluetooth on combo adapters is typically handled by the in-kernel 'btusb'"
	elog "driver with firmware from sys-firmware/linux-firmware."
}
