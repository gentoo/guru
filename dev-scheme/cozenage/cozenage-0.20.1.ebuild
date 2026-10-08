# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A Scheme-derived Lisp written in C"
HOMEPAGE="https://github.com/DarrenKirby/cozenage"
SRC_URI="https://github.com/DarrenKirby/cozenage/releases/download/v${PV}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="dev-libs/icu
	dev-libs/boehm-gc
	dev-libs/gmp
	dev-libs/openssl"
RDEPEND="${DEPEND}"
BDEPEND=" test? ( dev-libs/criterion ) "

src_test() {
	emake test
	COZENAGE_LIB_PATH="${S}/lib/cozenage" ./run_tests || die "tests failed"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install

	# install documentation
	dodoc *.md
	doman docs/cozenage.1
}
