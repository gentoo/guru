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

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=""
DEPEND="${RDEPEND}"
BDEPEND="app-arch/unzip"

DOCS=""
S="${WORKDIR}"
FONT_S="${S}/install_files"
FONT_SUFFIX="otf"

src_unpack() {
	unpack ${P}.zip
	unpack ${PN}-sc-${PV}.zip
	mkdir install_files
	mv ${MY_PN}/static/otf/* install_files/
	mv ${MY_PN}SC/static/otf/* install_files/
}
