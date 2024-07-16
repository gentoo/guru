# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
aho-corasick@1.1.3
atty@0.2.14
env_logger@0.9.3
hermit-abi@0.1.19
humantime@2.1.0
lazy_static@1.4.0
libc@0.2.155
log@0.4.22
memchr@2.7.4
proc-macro2@1.0.86
quote@1.0.36
regex-automata@0.4.7
regex-syntax@0.8.4
regex@1.10.5
syn@2.0.71
termcolor@1.4.1
thiserror-impl@1.0.62
thiserror@1.0.62
unicode-ident@1.0.12
winapi-i686-pc-windows-gnu@0.4.0
winapi-util@0.1.8
winapi-x86_64-pc-windows-gnu@0.4.0
winapi@0.3.9
windows-sys@0.52.0
windows-targets@0.52.6
windows_aarch64_gnullvm@0.52.6
windows_aarch64_msvc@0.52.6
windows_i686_gnu@0.52.6
windows_i686_gnullvm@0.52.6
windows_i686_msvc@0.52.6
windows_x86_64_gnu@0.52.6
windows_x86_64_gnullvm@0.52.6
windows_x86_64_msvc@0.52.6
"

inherit cargo

DESCRIPTION="Core logic for an AT&T / Teletype DMD 5620 terminal emulator"
HOMEPAGE="https://github.com/sethm/dmd_core"
SRC_URI="https://github.com/sethm/dmd_core/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+=" MIT Unicode-DFS-2016"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="test"

# There are inconsistencies in the minimum required version between
# the homepage of the package and the README of its primary consumer,
# developed by the same person. Since the primary consumer directly
# pulls up the library as a Git submodule (patched out to use a
# standalone library in Gentoo) and does not require Rust by itself,
# we presume that that is more accurate.
BDEPEND=">=virtual/rust-1.50.0"

src_install() {
	dolib.a target/$(usex debug debug release)/lib${PN}.a
	insinto /usr/$(get_libdir)/pkgconfig
	doins "${FILESDIR}"/dmd_core.pc
	sed -e "s/%VERSION%/${PV}/g" \
		-e "s:^libdir.*:libdir=${EPREFIX}/usr/$(get_libdir):" \
		-i "${ED}"/usr/$(get_libdir)/pkgconfig/dmd_core.pc || die
	einstalldocs
}
