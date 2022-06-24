# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CANNADICS=( bonobo )
DICSDIRFILE="${FILESDIR}/bonobo.dics.dir"
MYPN="pubdic-bonobo"

inherit cannadic

DESCRIPTION="supporting dictionaries for Canna"
HOMEPAGE="http://bonobo.gnome.gr.jp/~nakai/canna/"
SRC_URI="http://bonobo.gnome.gr.jp/~nakai/canna/${MYPN}-${PV}.tar.bz2"
S="${WORKDIR}/${MYPN}"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=">=app-i18n/canna-3.6_p3"
RDEPEND="${DEPEND}"

src_compile() {
	cat bonobo.p | sort >> y.p || die
	cat y.p | /usr/libexec/canna/pod - -p -i -2 > bonobo.spl || die
	mergeword < bonobo.spl > bonobo.t || die
	rm -rf bonobo.spl || die
}
