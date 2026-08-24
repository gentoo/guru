# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1

MY_PN="amneziawg-linux-kernel-module"
DESCRIPTION="AmneziaWG Linux kernel module"
HOMEPAGE="https://github.com/amnezia-vpn/amneziawg-linux-kernel-module"
SRC_URI="https://github.com/amnezia-vpn/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug"

CONFIG_CHECK="NET INET NET_UDP_TUNNEL CRYPTO_ALGAPI"

src_compile() {
	local modlist=( amneziawg=net:src::module )
	local modargs=(
		KERNELDIR=${KV_OUT_DIR}
	)
	use debug && modargs+=( CONFIG_AMNEZIAWG_DEBUG=y )
	linux-mod-r1_src_compile
}

pkg_postinst() {
	linux-mod-r1_pkg_postinst
	local old new
	if [[ $(uname -r) != "${KV_FULL}" ]]; then
		ewarn
		ewarn "You have just built AmneziaWG for kernel ${KV_FULL}, yet the currently running"
		ewarn "kernel is $(uname -r). If you intend to use this AmneziaWG module on the currently"
		ewarn "running machine, you will first need to reboot it into the kernel ${KV_FULL}, for"
		ewarn "which this module was built."
		ewarn
	elif [[ -f /sys/module/amneziawg/version ]] && \
			old="$(</sys/module/amneziawg/version)" && \
			new="$(modinfo -F version "${ROOT}/lib/modules/${KV_FULL}/net/amneziawg.ko" 2>/dev/null)" && \
			[[ $old != "$new" ]]; then
		ewarn
		ewarn "You appear to have just upgraded AmneziaWG from version v$old to v$new."
		ewarn "However, the old version is still running on your system. In order to use the"
		ewarn "new version, you will need to remove the old module and load the new one. As"
		ewarn "root, you can accomplish this with the following commands:"
		ewarn
		ewarn "    # rmmod amneziawg"
		ewarn "    # modprobe amneziawg"
		ewarn
		ewarn "Do note that doing this will remove current AmneziaWG interfaces, so you may want"
		ewarn "to gracefully remove them yourself prior."
		ewarn
	fi
}
