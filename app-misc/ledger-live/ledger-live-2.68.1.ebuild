# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Manager for the Ledger hardware wallet"
HOMEPAGE="https://www.ledger.com/"
SRC_URI="https://download.live.ledger.com/ledger-live-desktop-${PV}-linux-x86_64.AppImage -> ${P}.AppImage"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip"

DEPEND="sys-libs/zlib:="
RDEPEND="${DEPEND}
	sys-fs/fuse:0
"

QA_PREBUILT="*"
S="${DISTDIR}"

src_install() {
	newbin ${P}.AppImage ledger-live
}
