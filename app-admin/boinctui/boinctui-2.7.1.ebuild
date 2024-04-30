# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic

DESCRIPTION="Fullscreen text mode manager for the BOINC client"
HOMEPAGE="https://github.com/suleman1971/boinctui"
SRC_URI="mirror://debian/pool/main/${PN:0:1}/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug gnutls"

DEPEND="
	dev-libs/expat
	sys-libs/ncurses:=
	gnutls? ( net-libs/gnutls:=[openssl] )
	!gnutls? ( dev-libs/openssl:= )
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}"/${PN}-2.7.1-tinfo.patch )

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myeconfargs=(
		--with-boinc-dir="${EPREFIX}/var/lib/boinc"
		$(use_with gnutls)
	)
	econf "${myeconfargs[@]}"

	use debug && append-cppflags -DDEBUG
}

src_install() {
	emake DESTDIR="${D}" DOCDIR="${EPREFIX}/usr/share/doc/${PF}" install
}
