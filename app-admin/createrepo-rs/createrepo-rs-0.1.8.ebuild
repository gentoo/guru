# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo

DESCRIPTION="Pure Rust RPM repository metadata generator — dnf/yum-compatible, zero FFI"
HOMEPAGE="https://github.com/jamesarch/createrepo_rs"
SRC_URI="https://github.com/jamesarch/createrepo_rs/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/createrepo_rs-${PV}"

src_unpack() {
	cargo_live_src_unpack
}

src_compile() {
	cargo_src_compile --release
}

src_test() {
	cargo_src_test --release
}

src_install() {
	dobin "target/release/createrepo_rs"
	dodoc README.md README_zh.md
	dodoc LICENSE
}
