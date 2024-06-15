# Copyright 2024 Haelwenn (lanodan) Monnier <contact@hacktivis.me>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Public domain POSIX make"
HOMEPAGE="https://frippery.org/make"
SRC_URI="https://frippery.org/make/${P}.tgz"
LICENSE="Unlicense"
SLOT="0"
KEYWORDS="~amd64"

src_test() {
	pushd ./testsuite || die

	# Call manually instead of using `make test`
	# Seems to run in POSIX mode otherwise, leading to POSIX 2024 tests being skipped
	./runtest || die

	popd
}

src_install() {
	doman pdpmake.1
	emake install DESTDIR="${ED}" PREFIX=/usr
}
