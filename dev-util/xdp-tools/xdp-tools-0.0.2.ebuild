# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-info

DESCRIPTION="Utilities and example programs for use with XDP"
HOMEPAGE="https://github.com/xdp-project/xdp-tools"
SRC_URI="https://github.com/xdp-project/${PN}/releases/download/v${PV}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

# skip strip for eBPF object files
RESTRICT="strip"

# skip QA check(s) for eBPF samples
QA_EXECSTACK="usr/lib/bpf/*.o"

# XDP should be enabled
CONFIG_CHECK="~XDP_SOCKETS"

BDEPEND="
	virtual/pkgconfig
"
RDEPEND="
	>=dev-libs/libbpf-0.0.7
	virtual/libelf
"
DEPEND="${RDEPEND}
	>=sys-devel/clang-9.0.0
	>=sys-devel/llvm-9.0.0
"

src_configure() {
	./configure
}

src_compile() {
	emake PRODUCTION=1 PREFIX=/usr all
}

src_install() {
	emake PRODUCTION=1 PREFIX=/usr DESTDIR="${D}" install
	doman xdp-filter/xdp-filter.8
}
