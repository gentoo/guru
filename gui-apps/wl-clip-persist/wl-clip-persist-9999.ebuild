# Copyright 2024-2026 Gentoo Authors John M. Harris, Jr.
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RUST_MIN_VER="1.85.0"

inherit cargo git-r3

DESCRIPTION="Keep Wayland clipboard even after programs close"
HOMEPAGE="https://github.com/Linus789/wl-clip-persist"

EGIT_REPO_URI="https://github.com/Linus789/wl-clip-persist.git"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+=" Unicode-DFS-2016"
SLOT="0"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}
