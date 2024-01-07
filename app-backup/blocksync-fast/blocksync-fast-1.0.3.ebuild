# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Fast block device sync with digest, designed to improve block-based backups."
HOMEPAGE="https://github.com/nethappen/blocksync-fast/"
SRC_URI="https://github.com/nethappen/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+xxhash"

RDEPEND="
	>=dev-libs/libgcrypt-1.9.0:0=
	xxhash? ( >=dev-libs/xxhash-0.8 )"
DEPEND="${RDEPEND}"

src_configure() {
	eautoreconf
	econf $(use_with xxhash)
}

src_install() {
	DOCS=(README.md CHANGELOG.md LICENSE scripts)
	default_src_install
}
