# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="The Hare compiler"
HOMEPAGE="https://harelang.org/"
EGIT_COMMIT="62d4204f21332d97ad7697f628eade9137e9c3bc"
SRC_URI="https://git.sr.ht/~sircmpwn/harec/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${EGIT_COMMIT}/build"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~riscv"

DEPEND="sys-devel/qbe"
RDEPEND="${DEPEND}"

src_unpack() {
	default
	git-r3_src_unpack
	mkdir -p "${S}" || die
}

src_configure() {
	../configure --prefix="/usr" --libdir="/usr/$(get_libdir)" || die
}
