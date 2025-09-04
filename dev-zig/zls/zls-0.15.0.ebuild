# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Non-official language server for Zig"
HOMEPAGE="https://zigtools.org/zls/ https://github.com/zigtools/zls"

declare -g -r -A ZBS_DEPENDENCIES=(
	[known_folders-0.0.0-Fy-PJkfRAAAVdptXWXBspIIC7EkVgLgWozU5zIk5Zgcy.tar.gz]='https://github.com/ziglibs/known-folders/archive/92defaee76b07487769ca352fd0ba95bc8b42a2f.tar.gz'
	[diffz-0.0.1-G2tlIQrOAQCfH15jdyaLyrMgV8eGPouFhkCeYFTmJaLk.tar.gz]='https://github.com/ziglibs/diffz/archive/a20dd1f11b10819a6f570f98b42e1c91e3704357.tar.gz'
	[lsp_kit-0.1.0-bi_PL04yCgAxLsF0hH2a5sZKT84MGQaKXouw2jvCE8Nl.tar.gz]='https://github.com/zigtools/lsp-kit/archive/576e9405b1ab22c17c0f9318feed3278aa66b0ea.tar.gz'
	[N-V-__8AAMeOlQEipHjcyu0TCftdAi9AQe7EXUDJOoVe0k-t.tar.gz]='https://github.com/wolfpld/tracy/archive/refs/tags/v0.11.1.tar.gz'
)

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
		>=dev-lang/zig-0.15.0
		>=dev-lang/zig-bin-0.15.0
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
