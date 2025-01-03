# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo git-r3 shell-completion

DESCRIPTION="Efficient animated wallpaper daemon for wayland, controlled at runtime"
HOMEPAGE="https://github.com/LGFae/swww"
EGIT_REPO_URI="https://github.com/LGFae/swww.git"

LICENSE="GPL-3"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 BSD ISC MIT
	Unicode-DFS-2016
"
SLOT="0"

DEPEND="
	app-arch/lz4:=
	x11-libs/libxkbcommon[wayland]
"
RDEPEND="${DEPEND}"
BDEPEND="
	app-text/scdoc
"

QA_FLAGS_IGNORED="
	usr/bin/${PN}
	usr/bin/${PN}-daemon
"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_compile() {
	cargo_src_compile
	./doc/gen.sh || die # generate man pages
}

src_install() {
	dobin "$(cargo_target_dir)"/swww{,-daemon}
	doman doc/generated/*.1

	dodoc README.md CHANGELOG.md
	newbashcomp completions/swww.bash swww
	dofishcomp completions/swww.fish
	dozshcomp completions/_swww
}
