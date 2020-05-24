# Copyright 2020 Haelwenn (lanodan) Monnier <contact@hacktivis.me>
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="reasonable expectation of privacy"
HOMEPAGE="https://flak.tedunangst.com/post/reop"
SRC_URI="https://flak.tedunangst.com/files/reop-2.1.1.tgz"
LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/libsodium:="
RDEPEND="${DEPEND}"

src_compile() {
	emake CC="${CC}" CFLAGS="${CFLAGS}"
}

src_test() {
	cd ./tests || die
	source test.sh || die
	cd .. || die
}
src_install() {
	dobin reop
	doman reop.1
}
