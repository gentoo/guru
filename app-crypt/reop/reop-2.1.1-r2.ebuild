# Copyright 2020-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="reasonable expectation of privacy"
HOMEPAGE="https://flak.tedunangst.com/post/reop"
SRC_URI="https://flak.tedunangst.com/files/${P}.tgz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/libsodium:="
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/reop-2.1.1-base64-function-signatures.patch"
	"${FILESDIR}/reop-2.1.1-bcrypt_hash-cdata-sizeof.patch"
)

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}" LDFLAGS="-lsodium ${LDFLAGS}"
}

src_test() {
	cd ./tests || die
	sh ./test.sh || die
	cd .. || die
}
src_install() {
	dobin reop
	doman reop.1
}
