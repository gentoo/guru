# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="Libertinus"
inherit font

DESCRIPTION="Libertinus font"
HOMEPAGE="https://github.com/alerque/libertinus"
SRC_URI="https://github.com/alerque/libertinus/releases/download/v${PV}/${MY_PN}-${PV}.zip -> ${P}.tar.zip"

BDEPEND="app-arch/unzip"

S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DOCS="AUTHORS.txt CONTRIBUTING.md CONTRIBUTORS.txt FONTLOG.txt OFL.txt README.md"
FONT_S="${S}/static/OTF"
FONT_SUFFIX="otf"
