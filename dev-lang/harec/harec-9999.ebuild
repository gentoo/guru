# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="The Hare compiler"
HOMEPAGE="https://harelang.org/"
EGIT_REPO_URI="https://git.sr.ht/~sircmpwn/harec"
S="${WORKDIR}/${P}/build"
LICENSE="GPL-3"
SLOT="0"

DEPEND="sys-devel/qbe"
RDEPEND="${DEPEND}"

src_unpack() {
	default
	git-r3_src_unpack
	mkdir "${WORKDIR}/${P}/build" || die
}

src_configure() {
	../configure --prefix="/usr" --libdir="/usr/$(get_libdir)" || die
}
