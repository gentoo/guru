# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
PYTHON_REQ_USE="ssl"
inherit linux-info optfeature python-single-r1 systemd xdg

DESCRIPTION="Container-based approach to boot a full Android system on Linux systems"
HOMEPAGE="
	https://waydro.id
	https://github.com/waydroid/waydroid
"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
IUSE="apparmor"

RDEPEND="${PYTHON_DEPS}
	app-containers/lxc[apparmor?,seccomp]
	net-firewall/nftables
	net-dns/dnsmasq[dhcp]
	sys-apps/dbus
	sys-auth/polkit
	virtual/notification-daemon
	x11-libs/gtk+:3[introspection,wayland]
	x11-themes/hicolor-icon-theme
	$(python_gen_cond_dep '
		dev-python/dbus-python[${PYTHON_USEDEP}]
		>=dev-python/gbinder-1.3.0[${PYTHON_USEDEP}]
		dev-python/pygobject[${PYTHON_USEDEP}]
	')
	|| (
		media-video/pipewire[sound-server]
		media-sound/pulseaudio-daemon
	)
"
CONFIG_CHECK="
	~ANDROID_BINDER_IPC
	~ANDROID_BINDERFS
	~MEMFD_CREATE
	~NETFILTER_XT_TARGET_MASQUERADE
	~NETFILTER_XT_NAT
	~PSI
	~!PSI_DEFAULT_DISABLED
	~NF_TABLES
	~NF_TABLES_INET
	~NF_TABLES_NETDEV
	~NFT_NUMGEN
	~NFT_NAT
	~NFT_TUNNEL
	~NFT_QUOTA
	~NFT_SOCKET
	~NF_FLOW_TABLE
	~NFT_BRIDGE_META
	~NFT_BRIDGE_REJECT
"
ERROR_ANDROID_BINDERFS="CONFIG_ANDROID_BINDERFS: need for creating Android-specific binder IPC channels"
ERROR_ANDROID_BINDER_IPC="CONFIG_ANDROID_BINDER_IPC: need for creating Android-specific binder IPC channels"
ERROR_MEMFD_CREATE="CONFIG_MEMFD_CREATE: it completely replaced deprecated ISHMEM drivers,
	therefore it's vital for android-specific memory management"
ERROR_NETFILTER_XT_NAT="CONFIG_NETFILTER_XT_NAT: see bug #937106"
ERROR_NETFILTER_XT_TARGET_MASQUERADE="CONFIG_NETFILTER_XT_TARGET_MASQUERADE: see bug #937106"
ERROR_PSI="CONFIG_PSI: see bug #947280"
ERROR_NF_TABLES="CONFIG_NF_TABLES: Make sure you have NFTABLES up and running in your kernel"
ERROR_NFT_NAT="CONFIG_NFT_NAT: see bug #947280"
ERROR_NFT_BRIDGE_META="CONFIG_NFT_BRIDGE_META: see bug #947280"

pkg_setup() {
	linux-info_pkg_setup
	python-single-r1_pkg_setup
}

src_prepare() {
	if ! use apparmor; then
		# https://github.com/waydroid/waydroid/issues/652
		sed -e '/^lxc\.apparmor\.profile =/d' \
			-i data/configs/config_3 || die
	fi
	default
}

src_install() {
	python_fix_shebang waydroid.py
	newinitd "${FILESDIR}"/waydroid.initd waydroid

	local mymakeargs=(
		DESTDIR="${D}"
		PREFIX="${EPREFIX}"/usr
		SYSD_DIR="$(systemd_get_systemunitdir)"
		USE_NFTABLES=1
		USE_SYSTEMD=1
	)
	emake "${mymakeargs[@]}" install install_apparmor
}

pkg_postinst() {
	xdg_pkg_postinst

	elog "After package installation run either 'emerge --config app-containers/waydroid'"
	elog "or 'waydroid init' from root shell to install Android container runtime"
	elog "To run Waydroid, 1. Start container: 'rc-service waydroid start'"
	elog "2. Start Wayland channel (from user shell) 'waydroid session start'"
	elog "Contact https://docs.waydro.id/usage/install-on-desktops for how-to guides"
	elog "(does not cover Gentoo-specific things sadly)"
	elog
	ewarn "Make sure you have nftables up and running in your kernel. See"
	ewarn "https://wiki.gentoo.org/wiki/Nftables for how-to details"
	ewarn
	if use apparmor; then
		ewarn "Check the known issues for apparmor:"
		ewarn "https://docs.waydro.id/debugging/known-issues"
	fi

	optfeature "clipboard support" "dev-python/pyclip[wayland]"
}

pkg_config() {
	"${EROOT}"/usr/bin/waydroid init
}
