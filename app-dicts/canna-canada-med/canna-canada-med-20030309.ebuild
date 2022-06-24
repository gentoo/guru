# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CANNADICS=( med henkaku oldchar medinst medx sfx )

inherit cannadic

DESCRIPTION="medical term dictionary for canna"
HOMEPAGE="https://web.archive.org/web/20050723235132/http://spica.onh.go.jp/med_dic/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
S="${WORKDIR}/canada_med"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=">=app-i18n/canna-3.6_p3"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	mv dics.dir.add canadamed.dics.dir || die
	export DICSDIRFILE="${S}/canadamed.dics.dir"
}
