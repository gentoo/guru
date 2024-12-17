# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="The officially unofficial Ziglang language server"
HOMEPAGE="https://zigtools.org/zls/ https://github.com/zigtools/zls"

declare -g -r -A ZBS_DEPENDENCIES=(
	[diffz-1220102cb2c669d82184fb1dc5380193d37d68b54e8d75b76b2d155b9af7d7e2e76d.tar.gz]='https://github.com/ziglibs/diffz/archive/ef45c00d655e5e40faf35afbbde81a1fa5ed7ffb.tar.gz'
	[known_folders-12209cde192558f8b3dc098ac2330fc2a14fdd211c5433afd33085af75caa9183147.tar.gz]='https://github.com/ziglibs/known-folders/archive/0ad514dcfb7525e32ae349b9acc0a53976f3a9fa.tar.gz'
)

# Sync with "minimum_build_zig_version" from upstream's "build.zig".
if [[ ${PV} == 9999 ]]; then
	ZIG_SLOT="9999"

	EGIT_REPO_URI="https://github.com/zigtools/zls"
	inherit git-r3
else
	ZIG_SLOT="0.13"

	SRC_URI="
		https://github.com/zigtools/zls/archive/refs/tags/${PV}.tar.gz -> zls-${PV}.tar.gz
		https://codeberg.org/BratishkaErik/distfiles/releases/download/zls-${PV}/zls-${PV}-version_data.tar.xz
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
		>=dev-lang/zig-0.12.0
		>=dev-lang/zig-bin-0.12.0
	)
"

DOCS=( "README.md" )

src_unpack() {
	if [[ ${PV} == 9999 ]]; then
		git-r3_src_unpack
		zig_live_fetch -Denable_tracy=false
	else
		zig_src_unpack
	fi
}

src_configure() {
	local my_zbs_args=(
		-Dpie=true
		-Denable_tracy=false
	)

	zig_src_configure
}

pkg_postinst() {
	elog "You can find configuration guide here:"
	elog "https://zigtools.org/zls/"
}
