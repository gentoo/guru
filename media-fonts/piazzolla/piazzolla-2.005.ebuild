# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="Piazzolla"
inherit font

DESCRIPTION="Piazzolla font family"
HOMEPAGE="https://github.com/huertatipografica/piazzolla"
SRC_URI="
	https://github.com/huertatipografica/${PN}/releases/download/v${PV}/${MY_PN}.zip -> ${P}.zip
	https://github.com/huertatipografica/${PN}/releases/download/v${PV}/${MY_PN}SC.zip -> ${PN}-sc-${PV}.zip
	"

S="${WORKDIR}"
LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="app-arch/unzip"

FONT_S=(
	"${S}/${FONT_PN}/static/otf"
	"${S}/${FONT_PN}SC/static/otf"
)
FONT_SUFFIX="otf"

font_src_install() {
	insinto ${FONTDIR}
	doins ${MY_PN}/static/otf/*.otf ${MY_PN}SC/static/otf/*.otf
}
