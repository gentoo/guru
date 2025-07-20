EAPI=8

DESCRIPTION="A terminal hex dump tool"
HOMEPAGE="https://github.com/Arnau478/hevi"

declare -g -r -A ZBS_DEPENDENCIES=(
	[ziggy-1220c198cdaf6cb73fca6603cc5039046ed10de2e9f884cae9224ff826731df1c68d.tar.gz]="https://github.com/kristoff-it/ziggy/archive/ae30921d8c98970942d3711553aa66ff907482fe.tar.gz"
	[known-folders-12209cde192558f8b3dc098ac2330fc2a14fdd211c5433afd33085af75caa9183147.tar.gz]="https://github.com/ziglibs/known-folders/archive/0ad514dcfb7525e32ae349b9acc0a53976f3a9fa.tar.gz"
	[zig-lsp-kit-12204a4669fa6e8ebb1720e3581a24c1a7f538f2f4ee3ebc91a9e36285c89572d761.tar.gz]="https://github.com/MFAshby/zig-lsp-kit/archive/1c07e3e3305f8dd6355735173321c344fc152d3e.tar.gz"
	[yaml-1220841471bd4891cbb199d27cc5e7e0fb0a5b7c5388a70bd24fa3eb7285755c396c.tar.gz]="https://github.com/kubkon/zig-yaml/archive/beddd5da24de91d430ca7028b00986f7745b13e9.tar.gz"
)

ZIG_SLOT="0.13"
inherit zig

SRC_URI="
	https://github.com/Arnau478/hevi/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${ZBS_DEPENDENCIES_SRC_URI}
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_configure() {
	local my_zbs_args=(
		-Dpie=true
	)
	zig_src_configure
}
