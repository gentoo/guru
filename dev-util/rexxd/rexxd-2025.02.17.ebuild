# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo flag-o-matic toolchain-funcs

DESCRIPTION="Drop-in replacement for the original xxd"
HOMEPAGE="https://github.com/skeeto/w64devkit/blob/master/src/rexxd.c"

COMMIT="b217f139b86096c7864fc50f727d0ce81e4831d0"
SRC_URI="https://github.com/skeeto/w64devkit/raw/${COMMIT}/src/rexxd.c -> ${P}.c"
S="${WORKDIR}"
LICENSE="Unlicense"
KEYWORDS="~amd64 ~x86"

SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

src_unpack() {
	cp "${DISTDIR}/${P}.c" rexxd.c || die "cp failed"
}

src_compile() {
	append-cflags -D_FILE_OFFSET_BITS=64
	edo $(tc-getCC) ${CFLAGS} -o rexxd rexxd.c ${LDFLAGS}
	use test && edo $(tc-getCC) ${CFLAGS} -DTEST -o tests rexxd.c ${LDFLAGS}
}

src_install() {
	dobin rexxd
}

src_test() {
	edo ./tests
}
