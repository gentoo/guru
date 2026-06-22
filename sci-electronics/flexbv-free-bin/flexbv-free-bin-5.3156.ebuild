# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="Free version of the FlexBV boardview and schematic software"
HOMEPAGE="https://pldaniels.com/flexbv5/"
SRC_URI="https://pldaniels.com/flexbv5/releases/flexbv-free-${PV}-linux-x86_64.tar.gz"

S="${WORKDIR}/flexbv-free-${PV}-linux-x86_64"

LICENSE="FlexBV-Free-EULA"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="mirror test strip"

QA_PREBUILT="
	usr/bin/flexbv
"

RDEPEND="
	media-libs/fontconfig
	media-libs/libsdl2
	sys-libs/zlib
	virtual/opengl
"

src_install() {
	# install binary
	dobin flexbv

	# install desktop file
	domenu "${S}"/share/applications/flexbv.desktop

	# install icon
	doicon -s scalable "${S}"/share/icons/hicolor/scalable/apps/flexbv.svg

	# install metainfo and mime files
	insinto /usr/share/metainfo
	doins "${S}"/share/appdata/flexbv.appdata.xml

	insinto /usr/share/mime/packages
	doins "${S}"/share/mime/packages/flexbv.xml
}

pkg_postinst() {
	xdg_pkg_postinst
}

pkg_postrm() {
	xdg_pkg_postrm
}
