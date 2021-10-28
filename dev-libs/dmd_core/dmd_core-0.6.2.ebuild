# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
lazy_static-1.4.0
libc-0.2.103
"

inherit cargo toolchain-funcs

DESCRIPTION="Core logic for an AT&T / Teletype DMD 5620 terminal emulator"
HOMEPAGE="https://github.com/sethm/dmd_core"
SRC_URI="https://github.com/sethm/dmd_core/archive/v${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris ${CRATES})"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="test mirror"

BDEPEND=">=virtual/rust-1.47.0"

set_target_arch() {
	case "$(tc-arch)" in
		amd64) target_arch=x86_64 ;;
	esac
}

src_compile() {
	local target_arch
	set_target_arch
	cargo_src_compile --target ${target_arch}-unknown-linux-gnu
}

src_install() {
	local target_arch
	set_target_arch
	dolib.a "${S}"/target/${target_arch}-unknown-linux-gnu/release/lib${PN}.a
	insinto /usr/$(get_libdir)/pkgconfig
	cp "${FILESDIR}/dmd_core.pc" "${S}" || die "failed to copy pkgconfig file"
	sed -i "s/%VERSION%/${PV}/g" "${S}/dmd_core.pc" || die "failed to set version in pkgconfig file"
	doins "${S}/dmd_core.pc"

	sed -e "s:^libdir.*:libdir=${EPREFIX}/usr/$(get_libdir):" \
		-i "${ED}"/usr/$(get_libdir)/pkgconfig/dmd_core.pc || die "failed to set libdir in pkgconfig file"
	dodoc "${S}/LICENSE.txt"
	dodoc "${S}/README.md"
}
