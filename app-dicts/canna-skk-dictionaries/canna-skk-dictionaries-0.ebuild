# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CANNADICS=( geo zipcode )
DICSDIRFILE="${FILESDIR}/02skk-dictionaries.dics.dir"
MYPN="${PN/canna-/}"

inherit cannadic

DESCRIPTION="skk jisyo zipcode and geo datasets for canna"
HOMEPAGE="https://src.fedoraproject.org/rpms/Canna"
SRC_URI="https://src.fedoraproject.org/rpms/Canna/raw/f29/f/${MYPN}.patch"
S="${WORKDIR}"

LICENSE="public-domain GPL-2+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=">=app-i18n/canna-3.6_p3"
RDEPEND="${DEPEND}"

src_unpack() {
	mkdir -p dic/ideo/words/ || die
	tail -n +30 "${DISTDIR}/${MYPN}.patch" | patch -p1 || die
	mv dic/ideo/words/*.t -t . || die
	sed -e '/\# This/d' -e '/\# Date/d' -i *.t || die
}

src_compile() {
	mkbindic zipcode.t || die
	mkbindic geo.t || die
}
