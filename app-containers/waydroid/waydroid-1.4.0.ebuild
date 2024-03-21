# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
inherit linux-info xdg python-single-r1

DESCRIPTION="Container-based approach to boot a full Android system on Linux systems"
HOMEPAGE="https://waydro.id"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
IUSE="systemd apparmor"

DEPEND="|| ( virtual/linux-sources virtual/dist-kernel )"
RDEPEND="
	systemd? ( sys-apps/systemd )
	app-containers/lxc[systemd?,apparmor?,seccomp]
	$(python_gen_cond_dep '
		dev-python/pygobject[${PYTHON_USEDEP}]
		>=dev-python/gbinder-1.1.1[${PYTHON_USEDEP}]
		>=dev-python/pyclip-0.7.0[wayland,${PYTHON_USEDEP}]
		dev-python/dbus-python[${PYTHON_USEDEP}]
	')
	net-firewall/nftables
	net-dns/dnsmasq
	>=dev-libs/libglibutil-1.0.67
	>=dev-libs/gbinder-1.1.21
	${PYTHON_DEPS}
"

CONFIG_CHECK="
	~ANDROID_BINDER_IPC
	~ANDROID_BINDERFS
	~MEMFD_CREATE
"
ERROR_ANDROID_BINDERFS="CONFIG_ANDROID_BINDERFS: need for creating Android-specific binder IPC channels"
ERROR_ANDROID_BINDER_IPC="CONFIG_ANDROID_BINDER_IPC: need for creating Android-specific binder IPC channels"
ERROR_MEMFD_CREATE="CONFIG_MEMFD_CREATE: it completely replaced deprecated ISHMEM drivers,
	therefore it's vital for android-specific memory management"

src_compile() {
	:
}

src_install() {
	python_fix_shebang waydroid.py
	emake install DESTDIR="${D}" USE_NFTABLES=1 USE_SYSTEMD=$(usex systemd 1 0)
	if ! use systemd; then
		elog "Installing waydroid OpenRC daemon"
		doinitd "${FILESDIR}"/waydroid
	fi
}

pkg_postinst() {
	xdg_pkg_postinst

	elog "After package installation run either 'emerge --config app-containers/waydroid'"
	elog "or 'waydroid init' from root shell to install android container runtime"
	elog "To run waydroid, 1. Start container: 'rc-service waydroid start'"
	elog "2. start wayland channel (from user shell) 'waydroid session start'"
	elog "Contact https://docs.waydro.id/usage/install-on-desktops for how-to guides"
	elog "(does not cover Gentoo-specific things sadly)"
	elog

	ewarn "Make sure you have NFTABLES up and running in your kernel. See"
	ewarn "https://wiki.gentoo.org/wiki/Nftables for how-to details"
	ewarn

	if ! use apparmor; then
		ewarn "If you use app-containers/lxc without apparmor, make sure you deleted or commented out in waydroid LXC config"
		ewarn "(generated after waydroid init) in /var/lib/waydroid/lxc/waydroid/config the following string:"
		ewarn "lxc.apparmor.profile = unconfined"
		ewarn "or waydroid experiences crash during launch"
		ewarn "See also https://github.com/waydroid/waydroid/issues/652"
	else
		ewarn "Apparmor support has not been tested by package maintainer yet"
	fi
}

pkg_config() {
	"${EROOT}"/usr/bin/waydroid init
}
