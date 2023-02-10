# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="mueller-dict"
MY_P="${MY_PN}-${PV}"

inherit autotools

DESCRIPTION="V. K. Mueller English-Russian Dictionary"
HOMEPAGE="https://mueller-dict.sourceforge.net"
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="GPL-2"
IUSE="ipa"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"

RDEPEND=">=app-text/dictd-1.13.0-r3"
BDEPEND="
	${RDEPEND}
	dev-lang/perl
"

PATCHES=( "${FILESDIR}/${P}-dictfmt.patch" )

src_prepare() {
	rm -r "${S}"/dict/*.dz "${S}"/dict/*.index || die
	default
	eautoreconf
}

src_configure() {
	#preformat need the en_US.UTF-8 locale
	local myconf=(
		--enable-preformat
		$(use_enable ipa IPA-unicode)
	)

	econf "${myconf[@]}"
}

src_install() {
	dodoc NEWS README ChangeLog
	pushd "${S}/dict" || die
	insinto /usr/share/dict
	doins mueller-{abbrev,base,dict,geo,names}.{dict.dz,index}
}
