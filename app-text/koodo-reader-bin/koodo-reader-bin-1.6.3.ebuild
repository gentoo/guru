# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit rpm xdg
DESCRIPTION="A modern ebook manager and reader with sync and backup capacities"
HOMEPAGE="https://koodo.960960.xyz/"
SRC_URI="https://github.com/troyeguo/koodo-reader/releases/download/v${PV}/Koodo.Reader-${PV}-x86_64.rpm"
S="${WORKDIR}"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="-* ~amd64"

DEPEND="
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXfixes
	x11-libs/libXrandr
	media-libs/alsa-lib
	>=app-accessibility/at-spi2-core-2.46.0
	net-print/cups
	x11-libs/libdrm
	media-libs/mesa
	x11-libs/gtk+:3
	x11-libs/gdk-pixbuf
	dev-libs/nss
	x11-libs/pango
	x11-libs/libxkbcommon
"
RDEPEND="${DEPEND}"

QA_PREBUILT="opt/*"

src_install() {
	insinto /opt
	doins -r "${S}"/opt/Koodo\ Reader
	dosym ../../opt/Koodo\ Reader/koodo-reader "${EPREFIX}/usr/bin/koodo-reader"
	fperms +x /opt/Koodo\ Reader/koodo-reader
	insinto /usr
	doins -r "${S}"/usr/share
	doins -r "${S}"/usr/lib
}
