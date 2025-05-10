# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Non-official language server for Zig"
HOMEPAGE="https://zigtools.org/zls/ https://github.com/zigtools/zls"

declare -g -r -A ZBS_DEPENDENCIES=(
	[known_folders-0.0.0-Fy-PJtLDAADGDOwYwMkVydMSTp_aN-nfjCZw6qPQ2ECL.tar.gz]='https://github.com/ziglibs/known-folders/archive/aa24df42183ad415d10bc0a33e6238c437fc0f59.tar.gz'
	[lsp_codegen-0.1.0-CMjjo0ZXCQB-rAhPYrlfzzpU0u0u2MeGvUucZ-_g32eg.tar.gz]='https://github.com/zigtools/zig-lsp-codegen/archive/063a98c13a2293d8654086140813bdd1de6501bc.tar.gz'
	[N-V-__8AABhrAQAQLLLGadghhPsdxTgBk9N9aLVOjXW3ay0V.tar.gz]='https://github.com/ziglibs/diffz/archive/ef45c00d655e5e40faf35afbbde81a1fa5ed7ffb.tar.gz'
)

if [[ ${PV} == 9999 ]]; then
	ZIG_SLOT="9999"

	EGIT_REPO_URI="https://github.com/zigtools/zls"
	inherit git-r3
	src_unpack() {
		git-r3_src_unpack
		zig_live_fetch -Denable-tracy=false
	}
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

src_configure() {
	local my_zbs_args=(
		-Dpie=true
		-Denable-tracy=false
	)

	zig_src_configure
}
