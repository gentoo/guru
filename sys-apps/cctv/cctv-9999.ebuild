# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RUST_MIN_VER="1.85.0"
inherit cargo git-r3

DESCRIPTION="Terminal interface for CoolerControl"
HOMEPAGE="https://gitlab.com/coolercontrol/cctv"
EGIT_REPO_URI="https://gitlab.com/coolercontrol/cctv.git"

LICENSE="GPL-3+"
SLOT="0"

RDEPEND="dev-libs/openssl:="
DEPEND="${RDEPEND}"

QA_FLAGS_IGNORED=".*"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}
