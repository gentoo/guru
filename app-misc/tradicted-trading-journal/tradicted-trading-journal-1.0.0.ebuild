# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Free open-source desktop trading journal by Tradicted"
HOMEPAGE="https://www.tradicted.com"
SRC_URI="https://github.com/tradicted/tradicted-journal/releases/download/v${PV}/tradicted-trading-journal-${PV}.AppImage -> ${P}.AppImage"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip"

RDEPEND="sys-fs/fuse:0"

S="${WORKDIR}"

src_unpack() {
	cp "${DISTDIR}/${P}.AppImage" "${WORKDIR}/${P}.AppImage"
	chmod +x "${WORKDIR}/${P}.AppImage"
}

src_install() {
	insinto /opt/${PN}
	newins "${P}.AppImage" "${PN}.AppImage"
	fperms 0755 /opt/${PN}/${PN}.AppImage

	make_wrapper ${PN} /opt/${PN}/${PN}.AppImage

	domenu "${FILESDIR}/${PN}.desktop"
}
