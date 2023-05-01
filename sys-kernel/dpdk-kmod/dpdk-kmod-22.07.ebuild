# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_10 )
inherit linux-mod toolchain-funcs python-single-r1 meson

DESCRIPTION="DPDK Kernel Nic Interface module"
HOMEPAGE="https://dpdk.org/"
SRC_URI="https://fast.dpdk.org/rel/dpdk-${PV}.tar.xz"
S="${WORKDIR}/dpdk-${PV}"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
# tests need root
RESTRICT="test"

RDEPEND="${PYTHON_DEPS}"

DEPEND="${RDEPEND}
	$(python_gen_cond_dep '
		dev-python/pyelftools[${PYTHON_USEDEP}]
	')
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
BDEPEND="
	${PYTHON_DEPS}
"

PATCHES=( "${FILESDIR}/dpdk-22.03-binutils.patch" )

pkg_setup() {
	linux-mod_pkg_setup
	python-single-r1_pkg_setup
}

src_prepare() {
	default
	sed -e "s/@OBJDUMP@/$(tc-getOBJDUMP)/g" -i \
		buildtools/meson.build \
		buildtools/check-symbols.sh \
		devtools/check-abi-version.sh || die
}

src_configure() {
	linux-mod_pkg_setup
	python-single-r1_pkg_setup
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
