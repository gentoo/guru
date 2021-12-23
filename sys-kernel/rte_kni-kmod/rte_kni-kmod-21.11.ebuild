# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )
inherit linux-mod python-any-r1 meson

DESCRIPTION="DPDK Kernel Nic Interface module"
HOMEPAGE="https://dpdk.org/"
SRC_URI="https://fast.dpdk.org/rel/dpdk-${PV}.tar.xz"
S="${WORKDIR}/dpdk-${PV}"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/elfutils
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
	${PYTHON_DEPS}
"

CONFIG_CHECK="~IOMMU_SUPPORT ~AMD_IOMMU ~VFIO ~VFIO_PCI ~UIO ~UIO_PDRV_GENIRQ ~UIO_DMEM_GENIRQ ~HPET_MMAP"

pkg_setup() {
	linux-mod_pkg_setup
	python-any-r1_pkg_setup
}

src_configure() {
	# we still have to do meson configuration as it creates
	# header files needed for compiling the rte_kni module
	local emesonargs=(
		-Denable_kmods=false
		-Dmachine=default
		-Dplatform=generic
	)
	meson_src_configure

	# export after meson_src_configure as BUILD_DIR is needed for module compilation
	export MODULE_NAMES="rte_kni(extra/dpdk:${S}/kernel/linux/kni)"
	export BUILD_PARAMS="-C \"${KERNEL_DIR}\" M=\"${S}\"/kernel/linux/kni \
		src=\"${S}\"/kernel/linux/kni \
		MODULE_CFLAGS=\"${HAVE_ARG_TX_QUEUE} -include ${S}/config/rte_config.h -I${S}/lib/eal/include \
		-I${S}/lib/kni -I${S}/kernel/linux/kni -I${BUILD_DIR} -I${S}\""
	export BUILD_TARGETS="modules"
}

src_compile() {
	linux-mod_src_compile
}

src_install() {
	linux-mod_src_install
}
