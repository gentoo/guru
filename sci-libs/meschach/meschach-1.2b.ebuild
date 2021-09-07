# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit autotools eutils toolchain-funcs

MAJOR="$(ver_cut 1)"
VERSION="$(ver_cut 1-2)"

DESCRIPTION="Meschach is a C-language library of routines for performing matrix computations"
HOMEPAGE="http://homepage.divms.uiowa.edu/~dstewart/meschach"
SRC_URI="
	http://cdn-fastly.deb.debian.org/debian/pool/main/m/meschach/${PN}_${PV}.orig.tar.gz
	http://cdn-fastly.deb.debian.org/debian/pool/main/m/meschach/${PN}_${PV}-14.debian.tar.xz
"
LICENSE="meschach"
SLOT="0"
KEYWORDS="~amd64"

IUSE="complex +double float munroll old segmem sparse unroll"
REQUIRED_USE="
		^^ ( double float )
"

PATCHES=(
	"${WORKDIR}/debian/patches/${PN}_${PV}-13.diff"
	"${WORKDIR}/debian/patches/${PN}_${PV}-13.configure.diff"
	"${FILESDIR}/configure.patch"
	"${FILESDIR}/${PN}-2-mbdyn.diff"
	"${FILESDIR}/${PN}-makefile.patch"
)

src_prepare() {
	default
	mv configure.in configure.ac || die
	use old && sed -i -- 's/all: shared static/all: oldpart shared static/g' makefile.ac
	tc-export AR CC
	eautoreconf
}

src_configure() {
	myconf=(
		$(use_with complex)
		$(use_with double)
		$(use_with float)
		$(use_with munroll)
		$(use_with segmem)
		$(use_with sparse)
		$(use_with unroll)
	)
	econf "${myconf[@]}"
}

src_compile() {
	emake vers="${VERSION}" all
	emake alltorture
}

src_install() {
	ln -s "lib${PN}.so" "lib${PN}.so.${MAJOR}" || die
	ln -s "lib${PN}.so.${MAJOR}" "lib${PN}.so.${VERSION}" || die
	dolib.so "lib${PN}.so"
	dolib.so "lib${PN}.so.${MAJOR}"
	dolib.so "lib${PN}.so.${VERSION}"

	insinto "/usr/include/${PN}"
	doins *.h

	exeinto "/usr/libexec/${PN}"
	doexe iotort
	doexe itertort
	doexe memtort
	doexe mfuntort
	doexe sptort
	doexe torture
	doexe ztorture

	insinto "/usr/share/${P}"
	doins *.dat

	dodoc -r DOC/.
	einstalldocs
}
