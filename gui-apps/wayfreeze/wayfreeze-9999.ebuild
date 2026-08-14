# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo git-r3

DESCRIPTION="Tool to freeze the screen of a Wayland compositor "
HOMEPAGE="https://github.com/Jappie3/wayfreeze"
EGIT_REPO_URI="https://github.com/Jappie3/wayfreeze.git"
DOCS=( README.md )

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS=""

DEPEND="x11-libs/libxkbcommon"
RDEPEND="${DEPEND}"
BDEPEND="dev-lang/rust"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_compile() {
	cargo_src_compile
}

src_install() {
	dobin target/release/wayfreeze
	einstalldocs
}
