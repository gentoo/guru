# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo shell-completion

DESCRIPTION="Efficient animated wallpaper daemon for wayland, controlled at runtime"
HOMEPAGE="https://github.com/LGFae/swww"
if [[ ${PV} == *9999* ]]; then
    inherit git-r3
    EGIT_REPO_URI="https://github.com/LGFae/${PN}.git"
else
    SRC_URI="
    https://github.com/LGFae/swww/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
    ${CARGO_CRATE_URIS}
    "
    KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
# Dependent crate licenses
LICENSE+=" BSD MIT Unicode-3.0"
SLOT="0"
RUST_MIN_VER="1.89.0"

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
    if [[ "${PV}" == *9999* ]]; then
        git-r3_src_unpack
        cargo_live_src_unpack
    else
        cargo_src_unpack
    fi
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
