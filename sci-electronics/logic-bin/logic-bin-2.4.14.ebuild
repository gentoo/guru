# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Saleae logic analyzer"
HOMEPAGE="https://www.saleae.com"

SRC_URI="https://downloads.saleae.com/logic2/Logic-${PV}-linux-x64.AppImage"

S="${WORKDIR}"
LICENSE="Saleae"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="bindist mirror strip"

RDEPEND="sys-libs/zlib"

QA_PREBUILT="*"

src_unpack() {
	cp "${DISTDIR}/Logic-${PV}-linux-x64.AppImage" saleae-logic || die
}

src_install() {
	dobin saleae-logic
}
