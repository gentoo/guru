# Copyright 1999-2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Saleae logic analyzer"
HOMEPAGE="https://www.saleae.com"

SRC_URI="https://downloads.saleae.com/logic2/Logic-${PV}-master.AppImage"
KEYWORDS="~amd64 ~x86"

LICENSE="Saleae"
SLOT="0"

RESTRICT="bindist mirror strip"

S="${WORKDIR}"

QA_PREBUILT="*"

src_unpack() {
	cp "${DISTDIR}/Logic-2.4.0-master.AppImage" saleae-logic || die
}

src_install() {
	dobin saleae-logic
}
