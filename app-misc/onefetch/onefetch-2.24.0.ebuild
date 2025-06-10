# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RUST_MIN_VER="1.81.0"

inherit cargo shell-completion

DESCRIPTION="Command-line Git information tool"
HOMEPAGE="https://onefetch.dev"
SRC_URI="https://github.com/o2sh/onefetch/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz
	https://home.cit.tum.de/~salu/distfiles/${P}-crates.tar.xz
	https://home.cit.tum.de/~salu/distfiles/${P}-shellcomp.tar.xz
"
LICENSE="MIT"
# Dependent crate licenses
LICENSE+=" Apache-2.0 BSD ISC MPL-2.0 Unicode-3.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="app-arch/zstd:="
DEPEND="${RDEPEND}"
BDEPEND="
	dev-build/cmake
	virtual/pkgconfig
	test? (
		dev-vcs/git
		${RDEPEND}
	)
"

QA_FLAGS_IGNORED="usr/bin/onefetch"

pkg_setup() {
	export ZSTD_SYS_USE_PKG_CONFIG=1
	rust_pkg_setup
}

src_install() {
	doman docs/onefetch.1
	dodoc {CHANGELOG,README}.md

	dobashcomp "${WORKDIR}"/completions/onefetch
	dofishcomp "${WORKDIR}"/completions/onefetch.fish
	dozshcomp "${WORKDIR}"/completions/_onefetch
	cargo_src_install
}

pkg_postinst() {
	elog "Onefetch supports displaying images using x11-terms/kitty or any terminal emulator"
	elog "which supports the SIXEL graphics format or iTerm2's Inline Images Protocol."
	elog "See also: https://github.com/o2sh/onefetch/wiki/images-in-the-terminal"
}
