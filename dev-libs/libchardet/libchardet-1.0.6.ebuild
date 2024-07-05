# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Mozilla's Universal Charset Detector C/C++ API"
HOMEPAGE="https://github.com/Joungkyun/libchardet"
SRC_URI="https://github.com/Joungkyun/libchardet/releases/download/${PV}/${P}.tar.bz2"

LICENSE="LGPL-2.1 MPL-1.1"
SLOT="0/0"
KEYWORDS="~amd64"

PATCHES=(
	"${FILESDIR}/libchardet-1.0.6-pkgconfig.patch"
)

src_install() {
	default
	find "${ED}" -name "*.la" -delete || die
}
