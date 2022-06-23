# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CANNADICS=( basho kaom keisan pub scien sup )
DEBIAN="${PN}_${PV/_p/-}"
MYPV="$(ver_cut 1-3)"

inherit cannadic

DESCRIPTION="supporting dictionaries for Canna"
HOMEPAGE="https://web.archive.org/web/20051217013038/http://www.coolbrain.net:80/shion.html"
SRC_URI="
	mirror://debian/pool/main/c/${PN}/${PN}_${MYPV}.orig.tar.gz
	mirror://debian/pool/main/c/${PN}/${DEBIAN}.debian.tar.xz
"
S="${WORKDIR}/${PN}-${MYPV}.orig"

LICENSE="shion"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=">=app-i18n/canna-3.6_p3"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${P}-remove-first-line.patch" )

src_prepare() {
	default
	mv "${WORKDIR}/debian/shion.dics.dir.off" "${WORKDIR}/debian/shion.dics.dir" || die
	export DICSDIRFILE="${WORKDIR}/debian/shion.dics.dir"
}
