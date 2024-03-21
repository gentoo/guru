# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="FiraGO"
MY_PV="$(ver_rs 1 '')"
MY_P="Download_Folder_${MY_PN}_${MY_PV}"
FONT_SUFFIX=otf
inherit font

DESCRIPTION="A continuation of FiraSans"
HOMEPAGE="https://bboxtype.com/typefaces/FiraGO"
SRC_URI="https://bboxtype.com/downloads/${MY_PN}/${MY_P}.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	${RDEPEND}
	app-arch/unzip
"
S="${WORKDIR}/${MY_P}/Fonts"
DOCS=(
	${MY_PN}_${MY_PV}_CHANGE_LOG.rtf
)

src_prepare() {
	find -type f -path '*/*.[ot]tf' -exec mv -t . {} +
	default
}
