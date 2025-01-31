# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/jcalabro/uscope"
ZIG_SLOT="9999"
inherit git-r3 zig

DESCRIPTION="Native code graphical debugger and introspection toolchain"
HOMEPAGE="https://calabro.io/uscope https://github.com/jcalabro/uscope"

LICENSE="MIT"
SLOT="0"

DOCS=( "README.md" )

# Workaround failures for out-of-source build, fix in progress
BUILD_DIR="${S}"

src_unpack() {
	git-r3_src_unpack
	zig_live_fetch
}

src_configure() {
	local my_zbs_args=(
		-Dci=false
	)

	zig_src_configure
}
