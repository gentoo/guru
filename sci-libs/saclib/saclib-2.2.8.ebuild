# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MYP="${PN}${PV}"

inherit toolchain-funcs

DESCRIPTION="Reference implementations of algorithms and forms the basis of QEPCAD"
HOMEPAGE="https://www.usna.edu/Users/cs/wcbrown/qepcad/B/QEPCAD.html"
SRC_URI="https://www.usna.edu/Users/cs/wcbrown/qepcad/INSTALL/${MYP}.tgz"
S="${WORKDIR}/${MYP}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="debug"

BDEPEND="
	app-shells/bash
	app-shells/tcsh
"

PATCHES=(
	"${FILESDIR}/qepcad-compat.patch"
	"${FILESDIR}/makefile.patch"
)
DOCS=( doc/saclib.pdf doc/saclocal.dvi doc/desc.doc )

src_prepare() {
	MAJOR=$(ver_cut 1)
	MINOR=$(ver_cut 2)
	REVISION=$(ver_cut 3)
	export LIBNAME="lib${PN}.so"
	export MAJLIBNAME="${LIBNAME}.${MAJOR}"
	export MINMAJLIBNAME="${MAJLIBNAME}.${MINOR}"
	export FULLLIBNAME="${MINMAJLIBNAME}.${REVISION}"
	export saclib="${S}"
	tc-export CC CXX
	# no main, it's a library
	rm src/main.c || die
	default
}

src_configure() {
	cd "${saclib}/bin" || die
	./sconf || die
	./mkproto || die
	./mkmake || die
}

src_compile() {
	pushd "${saclib}/bin" || die
	if use debug ; then
		./mklib deb || die
	else
		./mklib opt || die
	fi
	popd || die
	pushd lib || die
	ln -s "${FULLLIBNAME}" "${MINMAJLIBNAME}" || die
	ln -s "${MINMAJLIBNAME}" "${MAJLIBNAME}" || die
	ln -s "${MAJLIBNAME}" "${LIBNAME}" || die
	popd || die
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
