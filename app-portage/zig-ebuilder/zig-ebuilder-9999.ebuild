# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Semi-automatic generator for Zig ebuilds"
HOMEPAGE="https://github.com/BratishkaErik/zig-ebuilder"

ZIG_SLOT="0.14"
EGIT_REPO_URI="https://github.com/BratishkaErik/zig-ebuilder"
inherit git-r3 zig

LICENSE="EUPL-1.2 MIT 0BSD CC0-1.0"
SLOT="0"

RDEPEND="
	|| (
		>=dev-lang/zig-0.13
		>=dev-lang/zig-bin-0.13
	)
"

DOCS=( "README.md" )

src_unpack() {
	git-r3_src_unpack
	zig_live_fetch
}
