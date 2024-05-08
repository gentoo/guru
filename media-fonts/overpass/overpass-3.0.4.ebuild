# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font

DESCRIPTION="An open source webfont family inspired by Highway Gothic"
HOMEPAGE="http://overpassfont.org/"
SRC_URI="https://github.com/RedHatOfficial/Overpass/archive/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/Overpass-${PV}"

LICENSE="|| ( LGPL-2.1 OFL-1.1 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_install() {

FONT_SUFFIX="otf" && FONT_S="${S}/desktop-fonts/overpass" font_src_install
FONT_SUFFIX="otf" && FONT_S="${S}/desktop-fonts/overpass-mono" font_src_install

}
