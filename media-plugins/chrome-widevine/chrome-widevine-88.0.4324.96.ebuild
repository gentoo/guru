# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker

CHROME_PN="google-chrome-stable"
CHROME_PV="${PV}"
CHROME_P="${CHROME_PN}_${CHROME_PV}-1"
CHROME_DIR="opt/google/chrome"

DESCRIPTION="An adapter for playing DRM content"
HOMEPAGE="https://www.google.com/chrome/"
SRC_URI="https://dl.google.com/linux/chrome/deb/pool/main/g/${CHROME_PN}/${CHROME_P}_amd64.deb"

LICENSE="google-chrome"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="bindist mirror strip"

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${CHROME_DIR}"

src_install() {
	insinto /opt/widevine/lib
	doins WidevineCdm/_platform_specific/linux_x64/libwidevinecdm.so
}
