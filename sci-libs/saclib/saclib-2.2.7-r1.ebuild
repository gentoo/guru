# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit toolchain-funcs

MYP="${PN}${PV}"

MAJOR=$(ver_cut 1)
MINOR=$(ver_cut 2)
REVISION=$(ver_cut 3)
LIBNAME="lib${PN}.so"
MAJLIBNAME="${LIBNAME}.${MAJOR}"
MINMAJLIBNAME="${MAJLIBNAME}.${MINOR}"
FULLLIBNAME="${MINMAJLIBNAME}.${REVISION}"

DESCRIPTION="Reference implementations of algorithms and forms the basis of QEPCAD"
HOMEPAGE="https://www.usna.edu/Users/cs/wcbrown/qepcad/B/QEPCAD.html"
SRC_URI="https://www.usna.edu/Users/cs/wcbrown/qepcad/INSTALL/${MYP}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="debug"

RDEPEND=""
DEPEND=""
BDEPEND="
	app-shells/bash
	app-shells/tcsh
"

S="${WORKDIR}/${MYP}"

DOCS=( doc/saclib.pdf doc/saclocal.dvi doc/desc.doc )

src_prepare() {
	export saclib="${S}"
	sed -i "s|SACFLAG=|SACFLAG=-fPIC ${CFLAGS} |g" bin/mklib || die
	default
	#TODO: disable static lib building
}

src_configure() {
	cd "${saclib}/bin" || die
	./sconf || die
	./mkproto || die
	./mkmake || die
}

src_compile() {
	cd "${saclib}/bin" || die
	if use debug ; then
		./mklib deb || die
		cd ../lib/objd || die
	else
		./mklib opt || die
		cd ../lib/objo || die
	fi

	echo $(tc-getCC) *.o "-fPIC -shared ${CFLAGS} ${LDFLAGS} -Wl,-soname,${FULLLIBNAME} -o ../${FULLLIBNAME}" > make.sh || die
	bash make.sh || die
	cd .. || die
	ln -s "${FULLLIBNAME}" "${MINMAJLIBNAME}" || die
	ln -s "${MINMAJLIBNAME}" "${MAJLIBNAME}" || die
	ln -s "${MAJLIBNAME}" "${LIBNAME}" || die
}

src_install() {
	einstalldocs
	dolib.so "lib/${FULLLIBNAME}"
	dolib.so "lib/${MINMAJLIBNAME}"
	dolib.so "lib/${MAJLIBNAME}"
	dolib.so "lib/${LIBNAME}"
	insinto /usr/include/saclib
	doins -r include/.
}
