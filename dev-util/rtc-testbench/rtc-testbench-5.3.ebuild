# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LLVM_COMPAT=( {15..20} )
PYTHON_COMPAT=( python3_{11..13} )

inherit cmake python-single-r1 llvm-r2

DESCRIPTION="RTC Testbench is a set of tools for validating Ethernet networks"
HOMEPAGE="https://github.com/Linutronix/RTC-Testbench"
SRC_URI="https://github.com/Linutronix/RTC-Testbench/archive/refs/tags/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
S="${WORKDIR}/RTC-Testbench-${PV}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc mqtt"

# Generated eBPF files
QA_PREBUILT="usr/lib*/rtc-testbench/ebpf/*.o"

REQUIRED_USE="
	${PYTHON_REQUIRED_USE}
"

BDEPEND="
	${PYTHON_DEPS}
	virtual/pkgconfig
	doc? (
		media-gfx/graphviz
		$(python_gen_cond_dep '
			dev-python/sphinx[${PYTHON_USEDEP}]
			dev-python/sphinx-rtd-theme[${PYTHON_USEDEP}]
		')
	)
	$(llvm_gen_dep '
		llvm-core/clang:${LLVM_SLOT}=[llvm_targets_BPF(-)]
	')
"
DEPEND="
	mqtt? ( app-misc/mosquitto )
	dev-libs/libyaml
	dev-libs/libbpf:=
	dev-libs/openssl:=
	net-libs/xdp-tools
"
RDEPEND="
	${PYTHON_DEPS}
	${DEPEND}
"

pkg_setup() {
	llvm-r2_pkg_setup
}

src_configure() {
	local mycmakeargs=(
		-DWITH_MQTT=$(usex mqtt)
	)

	cmake_src_configure
}

src_compile() {
	cmake_src_compile
	use doc && make -C "${S}/Documentation" html
}

src_install() {
	cmake_src_install
	use doc && HTML_DOCS=( "${S}/Documentation/_build/html" )
}
