# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_COMMIT="6479aa13f32f701c383083d8b28360ebd682fb7d"

ZIG_NEEDS_LLVM=1
ZIG_SLOT="0.15"

inherit zig

DESCRIPTION="Zig grammar for tree-sitter"
HOMEPAGE="https://github.com/tree-sitter-grammars/tree-sitter-zig"
SRC_URI="https://github.com/tree-sitter-grammars/tree-sitter-zig/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${EGIT_COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

src_prepare() {
	sed -e '/.install_subdir/s#queries#share/tree-sitter/queries/zig#' \
		-e '/node-types.json/d' \
		-i "${S}/build.zig" || die

	sed -e '2a .fingerprint = 0xb3d0096061c17516,' \
		-i "${S}/build.zig.zon" || die

	zig_src_prepare
}
