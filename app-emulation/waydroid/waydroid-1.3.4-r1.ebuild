#Relaismatrix/ Messung Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..10} )
inherit linux-info python-single-r1

DESCRIPTION="Container-based approach to boot a full Android system on Linux systems"
HOMEPAGE="https://waydro.id"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
IUSE="systemd"

DEPEND="|| ( virtual/linux-sources virtual/dist-kernel )
	sys-kernel/linux-headers"
RDEPEND="
	app-containers/lxc[systemd?]
	$(python_gen_cond_dep '
		dev-python/pygobject[${PYTHON_USEDEP}]
		dev-python/gbinder[${PYTHON_USEDEP}]
	')
	net-firewall/nftables[modern-kernel]
	net-dns/dnsmasq \
	${PYTHON_DEPS}
"

CONFIG_CHECK="
	~ANDROID_BINDER_IPC
	~ANDROID_BINDERFS
	~MEMFD_CREATE
"
ERROR_ANDROID_BINDERFS="CONFIG_ANDROID_BINDERFS: need for creating Android-specific binder IPC channels"
ERROR_ANDROID_BINDER_IPC="CONFIG_ANDROID_BINDER_IPC: need for creating Android-specific binder IPC channels"
ERROR_MEMFD_CREATE="CONFIG_MEMFD_CREATE: it completely replaced deprecated ISHMEM drivers, therefore it's vital for android-specific memory management"
src_install() {
	python_fix_shebang waydroid.py
	emake install DESTDIR="${D}" USE_NFTABLES=1 USE_SYSTEMD=$(usex systemd 1 0)
}
