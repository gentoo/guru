# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ ${PV} == "9999" ]]; then
	ZIG_SLOT="9999"
else
	ZIG_SLOT="0.13"
fi

inherit zig

DESCRIPTION="Performance Optimizer Observation Platform"
HOMEPAGE="https://github.com/andrewrk/poop"
if [[ ${PV} == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/andrewrk/poop"
else
	SRC_URI="
		https://github.com/andrewrk/poop/archive/refs/tags/${PV}.tar.gz
			-> ${P}.tar.gz
	"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

if [[ ${PV} == "9999" ]]; then
	src_unpack() {
		git-r3_src_unpack
		zig_live_fetch
	}
fi

src_configure() {
	local my_zbs_args=(
		-Dstrip=false # Let Portage control this
	)

	zig_src_configure
}
