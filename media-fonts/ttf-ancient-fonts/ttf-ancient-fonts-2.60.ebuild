# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

DESCRIPTION="Unicode font for Latin, IPA Extensions, Greek, Cyrillic and many Symbol Blocks"
HOMEPAGE="https://web.archive.org/web/20170707150432/http://users.teilar.gr:80/~g1951d"
SRC_URI="https://deb.debian.org/debian/pool/main/t/${PN}/${PN}_${PV}.orig.tar.xz -> ${P}.tar.xz"

S="${WORKDIR}/${P}.orig/"

LICENSE="Unicode_Fonts_for_Ancient_Scripts"
SLOT="0"
KEYWORDS="~amd64"

FONT_SUFFIX="ttf"
