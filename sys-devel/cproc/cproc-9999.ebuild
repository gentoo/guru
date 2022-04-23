# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="C11 compiler using QBE as backend"
HOMEPAGE="https://sr.ht/~mcf/cproc/"
EGIT_REPO_URI="https://git.sr.ht/~mcf/cproc"
LICENSE="ISC"
SLOT="0"
IUSE="system-qbe"

DEPEND="system-qbe? ( sys-devel/qbe:= )"
RDEPEND="${DEPEND}"

src_configure() {
	./configure \
		--prefix=/usr \
		|| die
}

src_compile() {
	if ! use system-qbe; then
		emake qbe
		PATH=$PWD/qbe/obj:$PATH emake
	else
		emake
	fi
}
