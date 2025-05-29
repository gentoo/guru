# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES=""

LLVM_COMPAT=( {17..19} )
RUST_NEEDS_LLVM=1

inherit llvm-r1 cargo

DESCRIPTION="Xwayland outside your Wayland"
HOMEPAGE="https://github.com/Supreeeme/xwayland-satellite"
SRC_URI="https://github.com/Supreeeme/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
DEPS_URI="https://github.com/freijon/${PN}/releases/download/v${PV}/${P}-crates.tar.xz"
SRC_URI+=" ${DEPS_URI}"

LICENSE="MPL-2.0"
# Dependent crate licenses
LICENSE+=" Apache-2.0 BSD ISC MIT Unicode-DFS-2016 ZLIB"
SLOT="0"
KEYWORDS="~amd64"

# disable tests which need a running display server
RESTRICT="test"

DEPEND="
	>=x11-base/xwayland-23.1
	x11-libs/libxcb
	x11-libs/xcb-util-cursor
"
RDEPEND="${DEPEND}"
BDEPEND="
	$(llvm_gen_dep 'llvm-core/clang:${LLVM_SLOT}=')
"

QA_FLAGS_IGNORED="usr/bin/${PN}"

DOCS=( README.md )

pkg_setup() {
	llvm-r1_pkg_setup
	rust_pkg_setup
}

src_install() {
	cargo_src_install
	einstalldocs
}
