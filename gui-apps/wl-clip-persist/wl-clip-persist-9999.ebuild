# Copyright 2024 John M. Harris, Jr.
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo git-r3

DESCRIPTION="Keep Wayland clipboard even after programs close"
HOMEPAGE="https://github.com/Linus789/wl-clip-persist"

EGIT_REPO_URI="https://github.com/Linus789/${PN}.git"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+=" Unicode-DFS-2016"
SLOT="0"

DEPEND="
	dev-libs/wayland-protocols
	dev-libs/wayland
"
RDEPEND="${DEPEND}"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_configure() {
	cargo_gen_config
	cargo_src_configure
}

src_compile() {
	cargo_src_compile
}

src_install() {
	cargo_src_install
}

# Rust package
QA_FLAGS_IGNORED="usr/bin/${PN}"
