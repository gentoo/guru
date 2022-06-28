# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CANNADICS=( yubin7 )
DICSDIRFILE="${FILESDIR}/yubin.dics.dir"

inherit cannadic

DESCRIPTION="Japanese postal code number extension dictionary for Canna"
HOMEPAGE="https://osdn.net/projects/canna-yubin/"
SRC_URI="https://jaist.dl.osdn.jp/${PN}/75047/${P}.tar.xz"

LICENSE="GPL-2+ public-domain"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=">=app-i18n/canna-3.6_p3"
RDEPEND="${DEPEND}"

src_compile() {
	MAKEOPTS="-j1" emake
}
