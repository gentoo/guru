# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN^}"
DESCRIPTION="Cursor theme using the Nord color palette and based on Vimix and cz-Viator"
HOMEPAGE="https://gitlab.com/gboehm/Nordzy-cursors"
SRC_URI="https://gitlab.com/gboehm/Nordzy-cursors/-/archive/v${PV}/Nordzy-cursors-v${PV}.tar.bz2 -> ${P}.tar.bz2"

S="${WORKDIR}/${MY_PN}-v${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="x11-libs/libXcursor"

src_install() {
	insinto /usr/share/icons
	doins -r "${S}"/xcursors/Nordzy-*
	doins -r "${S}"/hyprcursors/themes/Nordzy-*
}
