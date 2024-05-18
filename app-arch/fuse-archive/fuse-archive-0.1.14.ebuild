# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Read-only FUSE file system for mounting archives and compressed files"
HOMEPAGE="https://github.com/google/fuse-archive"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/google/fuse-archive.git"
else
	SRC_URI="https://github.com/google/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="Apache-2.0"
SLOT="0"

DEPEND="
	sys-fs/fuse:0
	app-arch/libarchive
"
RDEPEND="${DEPEND}"

# TODO(NRK): enable tests. requires additional dependency on dev-lang/go and such.
src_test() {
	:
}

src_compile() {
	emake CXX="$(tc-getCXX)" PKG_CONFIG="$(tc-getPKG_CONFIG)"
}

src_install() {
	dobin out/fuse-archive
}
