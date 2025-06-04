# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Non-official language server for Zig"
HOMEPAGE="https://zigtools.org/zls/ https://github.com/zigtools/zls"

if [[ ${PV} == 9999 ]]; then
	ZIG_SLOT="9999"

	EGIT_REPO_URI="https://github.com/zigtools/zls"
	inherit git-r3
else
	# Should be the "minimum_build_zig_version" from upstream's "build.zig".
	ZIG_SLOT="$(ver_cut 1-2)" # works only for releases, but that's okay

	SRC_URI="
		https://github.com/zigtools/zls/archive/refs/tags/${PV}.tar.gz -> zls-${PV}.tar.gz
	"
	KEYWORDS="~amd64"
fi

inherit zig
SRC_URI+="${ZBS_DEPENDENCIES_SRC_URI}"

LICENSE="MIT"
SLOT="0"

# Sync with "minimum_runtime_zig_version" from upstream's "build.zig".
RDEPEND="
	|| (
		>=dev-lang/zig-0.14.0
		>=dev-lang/zig-bin-0.14.0
	)
"

DOCS=( README.md )

if [[ ${PV} == 9999 ]]; then
	src_unpack() {
		git-r3_src_unpack
		zig_live_fetch -Denable-tracy=false
	}
fi

src_configure() {
	local my_zbs_args=(
		-Dpie=true
		-Denable-tracy=false
	)

	zig_src_configure
}
