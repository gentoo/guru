# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="55ff64349dec3012cfbbb1c4f92d4dbd46920213"

DESCRIPTION="libcrypt wrapper for LiteSpeedTech"
HOMEPAGE="https://github.com/litespeedtech/libbcrypt/"
SRC_URI="https://github.com/litespeedtech/libbcrypt/archive/${COMMIT}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/libbcrypt-${COMMIT}"

LICENSE="CC0-1.0 public-domain"
SLOT="0"
KEYWORDS="~amd64"

PATCHES=(
	"${FILESDIR}"/${PV}-fix-tests.patch
)

src_test() {
	default
	./bcrypt_test || die "Tests failed!"
}

src_install() {
	newlib.a bcrypt.a libbcrypt.a
	newheader bcrypt.h libbcrypt.h
	einstalldocs
}
