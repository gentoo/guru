# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker desktop xdg optfeature

DESCRIPTION="Linux SDL/ImGui edition software for viewing .brd files."
HOMEPAGE="https://openboardview.org"

SRC_URI="https://github.com/OpenBoardView/OpenBoardView/releases/download/${PV}/openboardview_${PV}-1_amd64.deb"

S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="strip test"

QA_PREBUILT="
	usr/bin/*
"
RDEPEND="
	dev-db/sqlite:3
	dev-libs/glib
	media-libs/fontconfig
	media-libs/freetype
	media-libs/libsdl2
	sys-libs/zlib
	x11-libs/gtk+:3
"
src_unpack() {
	unpacker_src_unpack
}

src_install() {
	# install the primary executable
	dobin "${S}"/usr/bin/openboardview

	# install desktop entry
	domenu "${S}"/usr/share/applications/openboardview.desktop

	# install application icon
	doicon -s scalable "${S}"/usr/share/icons/hicolor/scalable/apps/openboardview.svg

	# install metainfo and mimetype files
	insinto /usr/share/metainfo
	doins "${S}"/usr/share/metainfo/openboardview.appdata.xml

	insinto /usr/share/mime/packages
	doins "${S}"/usr/share/mime/packages/openboardview.xml
}

pkg_postinst() {
	xdg_pkg_postinst
	optfeature "converting legacy Microsoft Access-based .bv files via the bvconv.sh script" app-office/mdbtools
}

pkg_postrm() {
	xdg_pkg_postrm
}
