# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_11 )
inherit python-single-r1 toolchain-funcs meson

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
	$(python_gen_cond_dep '
		dev-python/pyelftools[${PYTHON_USEDEP}]
	')
	~sys-kernel/dpdk-kmod-${PV}[${PYTHON_SINGLE_USEDEP}]
	app-arch/libarchive
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
"

PATCHES=( "${FILESDIR}/dpdk-22.03-binutils.patch" )

src_prepare() {
	default
	sed -e "s/@OBJDUMP@/$(tc-getOBJDUMP)/g" -i \
		buildtools/meson.build \
		buildtools/check-symbols.sh \
		devtools/check-abi-version.sh || die
}

src_configure() {
	python-single-r1_pkg_setup
	local emesonargs=(
		-Denable_kmods=false
		-Dplatform=generic
		$(meson_use test tests)
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	python_fix_shebang "${ED}"
}
