# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
aho-corasick@1.1.3
atty@0.2.14
anstream@0.6.21
anstyle@1.0.14
anstyle-parse@0.2.7
anstyle-query@1.1.5
anstyle-wincon@3.0.11
bitflags@1.3.2
colorchoice@1.0.5
defmt@1.1.1
defmt-macros@1.1.1
env_logger@0.11.9
env_filter@1.0.1
hermit-abi@0.1.19
humantime@2.1.0
is_terminal_polyfill@1.70.2
lazy_static@1.5.0
libc@0.2.155
log@0.4.29
jiff@0.2.22
jiff-core@0.1.0
jiff-static@0.2.22
memchr@2.7.4
portable-atomic@1.14.0
portable-atomic-util@0.2.7
proc-macro2@1.0.107
quote@1.0.47
regex-automata@0.4.16
regex-syntax@0.8.11
regex@1.12.3
once_cell_polyfill@1.70.2
serde_core@1.0.225
serde_derive@1.0.225
syn@2.0.100
termcolor@1.4.1
thiserror-impl@2.0.18
thiserror@2.0.18
unicode-ident@1.0.12
utf8parse@0.2.2
winapi-i686-pc-windows-gnu@0.4.0
winapi-util@0.1.8
winapi-x86_64-pc-windows-gnu@0.4.0
winapi@0.3.9
windows-sys@0.61.2
windows-link@0.2.1
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
HOMEPAGE="https://git.loomcom.com/seth/dmd_core/"
SRC_URI="https://git.loomcom.com/seth/dmd_core/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"
S="${WORKDIR}/${PN}"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+=" MIT Unicode-DFS-2016"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="test"

src_install() {
	dolib.a "$(cargo_target_dir)"/lib${PN}.a
	insinto /usr/$(get_libdir)/pkgconfig
	doins "${FILESDIR}"/dmd_core.pc
	sed -e "s/%VERSION%/${PV}/g" \
		-e "s:^libdir.*:libdir=${EPREFIX}/usr/$(get_libdir):" \
		-i "${ED}"/usr/$(get_libdir)/pkgconfig/dmd_core.pc || die
	einstalldocs
}
