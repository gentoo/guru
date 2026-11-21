# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Jellyfin Desktop Client"
HOMEPAGE="https://github.com/jellyfin/jellyfin-desktop"
SRC_URI="https://github.com/jellyfin/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-qt/qtbase:6
	dev-qt/qtdeclarative:6
	dev-qt/qtwebchannel:6
	dev-qt/qtwebengine:6
	media-libs/libsdl2
	media-libs/mpvqt:6
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${P}-fix-mpvqt-build.patch" )
