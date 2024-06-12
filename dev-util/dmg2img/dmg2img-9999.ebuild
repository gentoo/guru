# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

EGIT_REPO_URI="https://github.com/Lekensteyn/dmg2img"

DESCRIPTION="Convert Apple disk images to IMG format."
LICENSE="GPL-2"
SLOT="0"
IUSE="lzfse"

DEPEND="app-arch/bzip2 dev-libs/openssl sys-libs/zlib lzfse? ( dev-libs/lzfse )"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

src_configure() {
    emake HAVE_LZFSE=$(usex lzfse 1 0)
}

src_install() {
	emake DESTDIR=${D} install
}
