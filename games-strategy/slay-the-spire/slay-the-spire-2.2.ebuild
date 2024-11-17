# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CHECKREQS_DISK_BUILD="550M"
inherit check-reqs desktop unpacker xdg

DESCRIPTION="Deck-building roguelike game with four playable characters"
HOMEPAGE="https://www.megacrit.com/"
SRC_URI="slay_the_spire_2020_12_15_8735c9fe3cc2280b76aa3ec47c953352a7df1f65_43444.sh"
S="${WORKDIR}/data/noarch/game"

LICENSE="GOG-EULA"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist fetch splitdebug"

BDEPEND="
	app-arch/unzip
"

# Does not run with dev-java/openjdk: #894768
RDEPEND="
	dev-java/openjdk-bin
	virtual/libc
	x11-apps/xrandr
	x11-libs/libX11
	x11-libs/libXcursor
	x11-libs/libXext
	x11-libs/libXrandr
	x11-libs/libXxf86vm
"

DIR="/opt/${PN}"
QA_PREBUILT="${DIR#/}/*"

pkg_nofetch() {
	einfo "Please buy and download ${SRC_URI} from:"
	einfo "  ${HOMEPAGE}"
	einfo "and move it to your distfiles directory."
}

src_unpack() {
	unpack_zip "${A}"
}

src_install() {
	insinto "${DIR}"
	doins desktop-1.0.jar mod-uploader.jar mts-launcher.jar
	doins "${WORKDIR}/data/noarch/support/icon.png"

	dobin "${FILESDIR}/slay-the-spire"

	make_desktop_entry ${PN} "Slay the Spire" "${EPREFIX}${DIR}"/icon.png
}
