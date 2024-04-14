# Copyright 2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit wrapper

DESCRIPTION="Re-Engineered visual novel with accessibility features"
HOMEPAGE="https://www.fhs.sh/projects"
SRC_URI="https://github.com/fleetingheart/ksre/releases/download/v$PV/KSRE-linux.tar.bz2"

LICENSE="
	MPL-2.0
	CC-BY-NC-ND-3.0
"

SLOT="0"
KEYWORDS="~amd64"

QA_PREBUILT="*"
RESTRICT="strip"

S="${WORKDIR}/KSRE-linux"

src_install() {
	dodir etc
	cp -r . "$ED/opt/$PN" || die

	make_wrapper ${PN} "/opt/${PN}/Katawa\ Shoujo\ Re-Engineered.sh"

}
