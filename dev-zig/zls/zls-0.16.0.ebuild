# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Non-official language server for Zig"
HOMEPAGE="https://zigtools.org/zls/ https://github.com/zigtools/zls"

declare -g -r -A ZBS_DEPENDENCIES=(
	[diffz-0.0.1-G2tlISzNAQCldmOcINavGmF1zdt20NFPXeM8d07jp_68.tar.gz]='https://github.com/ziglibs/diffz/archive/b39fe07e7fdbcf56e43ba2890b9f484f16969f90.tar.gz'
	[known_folders-0.0.0-Fy-PJk3KAACzUg2us_0JvQQmod1ZA8jBt7MuoKCihq88.tar.gz]='https://github.com/ziglibs/known-folders/archive/d6d03830968cca6b7b9f24fd97ee348346a6905d.tar.gz'
	[lsp_kit-0.1.0-bi_PL3IyDACfp1xdTnkiOHEok2YpPCCCJHuuOcNzjl1D.tar.gz]='https://github.com/zigtools/lsp-kit/archive/b886a2b0d5cee85ecbcc3089b863f7517cc9ff7f.tar.gz'
	[N-V-__8AAOncKwEm1F9c5LrT7HMNmRMYX8-fAoqpc6YyTu9X.tar.gz]='https://github.com/wolfpld/tracy/archive/refs/tags/v0.13.1.tar.gz'
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
		>=dev-lang/zig-0.16.0
		>=dev-lang/zig-bin-0.16.0
	)
"

DOCS=( README.md )

if [[ ${PV} == 9999 ]]; then
	src_unpack() {
		git-r3_src_unpack
		zig_live_src_unpack
	}
fi

src_configure() {
	local my_zbs_args=(
		-Dpie=true
		-Denable-tracy=false
	)

	zig_src_configure
}
