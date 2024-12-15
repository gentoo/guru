# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/andrewrk/poop"
ZIG_SLOT="9999"
inherit git-r3 zig

DESCRIPTION="Performance Optimizer Observation Platform"
HOMEPAGE="https://github.com/andrewrk/poop"

LICENSE="MIT"
SLOT="0"

DOCS=( "README.md" )

src_unpack() {
	git-r3_src_unpack
	zig_live_fetch
}

src_configure() {
	local my_zbs_args=(
		-Dstrip=false # Let Portage control this
	)

	zig_src_configure
}
