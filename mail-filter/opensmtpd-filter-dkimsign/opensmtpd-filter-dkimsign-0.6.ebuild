# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

MY_P="${P#opensmtpd-}"
DESCRIPTION="OpenSMTPD filter for DKIM signing"
HOMEPAGE="http://imperialat.at/dev/filter-dkimsign/"
SRC_URI="http://imperialat.at/releases/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ed25519"

DEPEND="
	dev-libs/libopensmtpd:=
	dev-libs/openssl:=
"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

src_configure() {
	tc-export CC
}

src_compile() {
	local myargs=(
		MANFORMAT=mdoc
		LIBCRYPTOPC=libcrypto
		$(usex ed25519 HAVE_ED25519=1 '')
	)
	emake -f Makefile.gnu "${myargs[@]}"
}

src_install() {
	local myargs=(
		MANFORMAT=mdoc
		DESTDIR="${D}"
		LOCALBASE="${EPREFIX}"/usr
	)
	emake -f Makefile.gnu "${myargs[@]}" install
}
