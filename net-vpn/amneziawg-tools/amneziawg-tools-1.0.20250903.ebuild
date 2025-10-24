# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info bash-completion-r1 systemd toolchain-funcs

DESCRIPTION="Required tools for AmneziaWG, such as awg(8) and awg-quick(8)"
HOMEPAGE="https://github.com/amnezia-vpn/amneziawg-tools"
SRC_URI="https://github.com/amnezia-vpn/amneziawg-tools/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="+awg-quick selinux"

BDEPEND="virtual/pkgconfig"
RDEPEND="${DEPEND}
	awg-quick? (
		|| ( net-firewall/nftables net-firewall/iptables )
		virtual/resolvconf
	)
	selinux? ( sec-policy/selinux-wireguard )
"

awg_quick_optional_config_nob() {
	CONFIG_CHECK="$CONFIG_CHECK ~$1"
	declare -g ERROR_$1="CONFIG_$1: This option is required for automatic routing of default routes inside of awg-quick(8), though it is not required for general AmneziaWG usage."
}

pkg_setup() {
	if use awg-quick; then
		awg_quick_optional_config_nob IP_ADVANCED_ROUTER
		awg_quick_optional_config_nob IP_MULTIPLE_TABLES
		awg_quick_optional_config_nob IPV6_MULTIPLE_TABLES
		if has_version net-firewall/nftables; then
			awg_quick_optional_config_nob NF_TABLES
			awg_quick_optional_config_nob NF_TABLES_IPV4
			awg_quick_optional_config_nob NF_TABLES_IPV6
			awg_quick_optional_config_nob NFT_CT
			awg_quick_optional_config_nob NFT_FIB
			awg_quick_optional_config_nob NFT_FIB_IPV4
			awg_quick_optional_config_nob NFT_FIB_IPV6
			awg_quick_optional_config_nob NF_CONNTRACK_MARK
		elif has_version net-firewall/iptables; then
			awg_quick_optional_config_nob NETFILTER_XTABLES
			awg_quick_optional_config_nob NETFILTER_XT_MARK
			awg_quick_optional_config_nob NETFILTER_XT_CONNMARK
			awg_quick_optional_config_nob NETFILTER_XT_MATCH_COMMENT
			awg_quick_optional_config_nob NETFILTER_XT_MATCH_ADDRTYPE
			awg_quick_optional_config_nob IP6_NF_RAW
			awg_quick_optional_config_nob IP_NF_RAW
			awg_quick_optional_config_nob IP6_NF_FILTER
			awg_quick_optional_config_nob IP_NF_FILTER
		fi
	fi
	get_version
	if ! has_version net-vpn/amneziawg-modules; then
		ewarn
		ewarn "Linux kernel does not have upstream support for AmneziaWG."
		ewarn "However, the net-vpn/amneziawg-modules ebuild"
		ewarn "contains a module that should work for your kernel."
		ewarn "It is highly recommended to install it:"
		ewarn
		ewarn "    emerge -av net-vpn/amneziawg-modules"
		ewarn
	fi
	linux-info_pkg_setup
}

src_compile() {
	emake RUNSTATEDIR="${EPREFIX}/run" -C src CC="$(tc-getCC)" LD="$(tc-getLD)"
}

src_install() {
	dodoc README.md
	dodoc -r contrib
	emake \
		WITH_BASHCOMPLETION=yes \
		WITH_SYSTEMDUNITS=yes \
		WITH_WGQUICK=$(usex awg-quick) \
		DESTDIR="${D}" \
		BASHCOMPDIR="$(get_bashcompdir)" \
		SYSTEMDUNITDIR="$(systemd_get_systemunitdir)" \
		PREFIX="${EPREFIX}/usr" \
		-C src install
	use awg-quick && newinitd "${FILESDIR}/awg-quick.init" awg-quick
}
