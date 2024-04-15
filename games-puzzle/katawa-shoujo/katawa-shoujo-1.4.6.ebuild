# Copyright 2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit wrapper desktop

DESCRIPTION="Re-Engineered visual novel with accessibility features"
HOMEPAGE="https://www.fhs.sh/projects"
SRC_URI="
	https://github.com/fleetingheart/ksre/releases/download/v$PV/KSRE-linux.tar.bz2 -> ${P}.tar.bz2
	https://github.com/fleetingheart/web/blob/main/public/android-chrome-512x512.png -> ${PN}.png
"
S="${WORKDIR}/KSRE-linux"

LICENSE="
	MPL-2.0
	CC-BY-NC-ND-3.0
"

SLOT="0"
KEYWORDS="~amd64"

QA_PREBUILT="*"
RESTRICT="strip"

src_install() {
	insinto "/opt/${PN}"
	doins -r *

	fperms +x "/opt/${PN}/Katawa Shoujo Re-Engineered.sh"
	fperms +x "/opt/${PN}/lib/py3-linux-x86_64/Katawa Shoujo Re-Engineered"

	make_wrapper "${PN}" "/opt/${PN}/Katawa\ Shoujo\ Re-Engineered.sh"

	domenu "${FILESDIR}/${PN}.desktop"
	doicon "${DISTDIR}/${PN}.png"
}
