# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Library for creating OpenSMTPD filters"
HOMEPAGE="http://imperialat.at/dev/libopensmtpd/"
SRC_URI="http://imperialat.at/releases/${P}.tar.gz"

LICENSE="ISC"
SLOT="0/0.1"
KEYWORDS="~amd64"

DEPEND="dev-libs/libevent:="
RDEPEND="${DEPEND}"

src_configure() {
	tc-export CC
}

src_compile() {
	local myargs=(
		MANFORMAT=mdoc
	)
	emake -f Makefile.gnu "${myargs[@]}"
}

src_install() {
	local myargs=(
		MANFORMAT=mdoc
		DESTDIR="${D}"
		LOCALBASE="${EPREFIX}"/usr
		LIBDIR="${EPREFIX}"/usr/$(get_libdir)
	)
	emake -f Makefile.gnu "${myargs[@]}" install
}
