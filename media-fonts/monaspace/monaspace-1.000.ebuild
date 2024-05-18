# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

DESCRIPTION="A free and open-source typeface for developers"
HOMEPAGE="https://github.com/githubnext/monaspace"
SRC_URI="https://github.com/githubnext/monaspace/releases/download/v${PV}/monaspace-v${PV}.zip"

S="${WORKDIR}/monaspace-v${PV}"
LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64"

FONT_S="${S}/fonts/total"
FONT_SUFFIX=""
IUSE="variable +otf"
REQUIRED_USE="|| ( otf variable )"

BDEPEND="app-arch/unzip"

src_prepare() {
	default

	mkdir "${S}/fonts/total" || die

	if use otf ; then
		mv "${S}/fonts/otf/"* "${S}/fonts/total" || die
		FONT_SUFFIX="${FONT_SUFFIX} otf"
	fi

	if use variable ; then
		mv "${S}/fonts/variable/"* "${S}/fonts/total" || die
		FONT_SUFFIX="${FONT_SUFFIX} ttf"
	fi
}
