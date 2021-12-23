# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )
inherit python-single-r1 meson

DESCRIPTION="Data Plane Development Kit libraries for fast userspace networking"
HOMEPAGE="https://dpdk.org/"
SRC_URI="https://fast.dpdk.org/rel/${P}.tar.xz"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
# tests require rte_kni module to be loaded
# and also needs network and /dev access
# and need to be run as root
RESTRICT="test"

DEPEND="${PYTHON_DEPS}
	~sys-kernel/rte_kni-kmod-${PV}
	app-crypt/intel-ipsec-mb
	dev-libs/elfutils
	dev-libs/isa-l
	dev-libs/jansson
	dev-libs/libbpf
	dev-libs/libbsd
	dev-libs/openssl
	net-libs/libmnl
	net-libs/libpcap
	sys-apps/dtc
	sys-cluster/rdma-core
	sys-process/numactl
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-lang/nasm
	test? ( $(python_gen_cond_dep '
		dev-python/pyelftools[${PYTHON_USEDEP}]
	') )
"

src_configure() {
	local emesonargs=(
		-Denable_kmods=false
		-Dmachine=default
		-Dplatform=generic
		$(meson_use test tests)
	)
	meson_src_configure
	python_setup
}

src_install() {
	meson_src_install
	local pyfiles=( "${ED}"/usr/bin/*.py )
	for pyfile in "${pyfiles[@]}"; do
		python_fix_shebang "${pyfile}"
	done
}
