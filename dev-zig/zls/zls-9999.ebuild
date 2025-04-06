# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="The officially unofficial Ziglang language server"
HOMEPAGE="https://zigtools.org/zls/ https://github.com/zigtools/zls"

# Sync with "minimum_build_zig_version" from upstream's "build.zig".
if [[ ${PV} == 9999 ]]; then
	ZIG_SLOT="9999"

	EGIT_REPO_URI="https://github.com/zigtools/zls"
	inherit git-r3
else
	ZIG_SLOT="0.14"

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

DOCS=( "README.md" )

src_unpack() {
	if [[ ${PV} == 9999 ]]; then
		git-r3_src_unpack
		zig_live_fetch -Denable-tracy=false
	else
		zig_src_unpack
	fi
}

src_configure() {
	local my_zbs_args=(
		-Dpie=true
		-Denable-tracy=false
	)

	zig_src_configure
}

pkg_postinst() {
	elog "You can find configuration guide here:"
	elog "https://zigtools.org/zls/"
}
