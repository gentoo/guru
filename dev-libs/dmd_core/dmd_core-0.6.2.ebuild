# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
lazy_static@1.4.0
libc@0.2.103
"

inherit cargo

DESCRIPTION="Core logic for an AT&T / Teletype DMD 5620 terminal emulator"
HOMEPAGE="https://github.com/sethm/dmd_core"
SRC_URI="https://github.com/sethm/dmd_core/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="test"

BDEPEND=">=virtual/rust-1.47.0"

src_install() {
	dolib.a target/$(usex debug debug release)/lib${PN}.a
	insinto /usr/$(get_libdir)/pkgconfig
	cp "${FILESDIR}/dmd_core.pc" "${S}" || die "failed to copy pkgconfig file"
	sed -i "s/%VERSION%/${PV}/g" "${S}/dmd_core.pc" || die "failed to set version in pkgconfig file"
	doins "${S}/dmd_core.pc"

	sed -e "s:^libdir.*:libdir=${EPREFIX}/usr/$(get_libdir):" \
		-i "${ED}"/usr/$(get_libdir)/pkgconfig/dmd_core.pc || die "failed to set libdir in pkgconfig file"
	dodoc "${S}/LICENSE.txt"
	dodoc "${S}/README.md"
}
