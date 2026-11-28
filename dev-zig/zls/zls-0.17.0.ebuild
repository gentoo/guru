# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Non-official language server for Zig"
HOMEPAGE="https://zigtools.org/zls/ https://github.com/zigtools/zls"

declare -g -r -A ZBS_DEPENDENCIES=(
	[diffz-0.0.1-G2tlISvOAQDORzPTSxDgiKwlHuADKeJMdJrw4kRfLufj.tar.gz]='https://github.com/ziglibs/diffz/archive/aac8aa99c436ab8277b0711922aad062c0167b12.tar.gz'
	[known_folders-0.0.0-Fy-PJiDLAAB98m3uYUzatrTb2mO2fpvwx2zpSroEtfbO.tar.gz]='https://github.com/ziglibs/known-folders/archive/6da0d0c41b78b9ed2d34fa364fcb81b5ebece6c4.tar.gz'
	[lsp_kit-0.1.0-bi_PL9o2DADHS1PDra3MGz1MXnsboN_ewNvrc419z7Fb.tar.gz]='https://github.com/zigtools/lsp-kit/archive/3e1058db66079911fdde82f833fdce6856e0a706.tar.gz'
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
		>=dev-lang/zig-0.17.0
		>=dev-lang/zig-bin-0.17.0
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
