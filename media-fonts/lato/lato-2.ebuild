# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

DESCRIPTION="Lato font"
HOMEPAGE="https://www.latofonts.com/"
SRC_URI="https://www.latofonts.com/files/Lato2OFL.zip -> ${P}.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DOCS="OFL.txt README.txt"
S="${WORKDIR}/Lato2OFL"
FONT_SUFFIX="ttf"

BDEPEND="app-arch/unzip"
