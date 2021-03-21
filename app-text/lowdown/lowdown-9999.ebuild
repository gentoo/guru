# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="simple markdown translator"
HOMEPAGE="https://kristaps.bsd.lv/lowdown/"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/kristapsdz/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://kristaps.bsd.lv/${PN}/snapshots/${P}.tar.gz"
	KEYWORDS="~*"
fi

LICENSE="ISC"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""

src_prepare() {
	default

	# note: not an autoconf configure script (oconfigure)
	cat <<-EOF > "configure.local"
		PREFIX="${EPREFIX}/usr"
		BINDIR="${EPREFIX}/usr/bin"
		SBINDIR="${EPREFIX}/usr/sbin"
		LIBDIR="${EPREFIX}/usr/$(get_libdir)"
		MANDIR="${EPREFIX}/usr/share/man"
		INCLUDEDIR="${EPREFIX}/usr/include"

		CFLAGS="${CFLAGS} ${CPPFLAGS}"
		LDFLAGS="${LDFLAGS}"
		CC="$(tc-getCC)"

		# fix utf-8 locale on musl
		$(usex elibc_musl UTF8_LOCALE=C.UTF-8 '')
	EOF
}

src_configure() {
	./configure
}
