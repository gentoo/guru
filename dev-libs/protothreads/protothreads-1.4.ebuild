# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DESCRIPTION="Protothreads - Lightweight, Stackless Threads in C"
HOMEPAGE="https://web.archive.org/web/20190923093100/http://dunkels.com/adam/pt/"
SRC_URI="
	https://web.archive.org/web/20190518175329/http://dunkels.com/adam/download/pt-${PV}.tar.gz -> ${P}.tar
	https://web.archive.org/web/20190518175329/http://dunkels.com/adam/download/graham-pt.h
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc examples"

BDEPEND="doc? ( app-doc/doxygen )"

S="${WORKDIR}/pt-${PV}"

src_unpack() {
	default
	cp "${DISTDIR}/graham-pt.h" "${S}"
}

src_prepare() {
	sed -i 's/-Werror//g' Makefile
	sed -i 's/-O//g' Makefile
	default
}

src_compile() {
	default
	use doc && cd doc && emake
}

src_install() {
	insinto "/usr/include/${PN}"
	doins *.h
	if use doc ; then
		dodoc doc/*.pdf
		dodoc doc/*.txt
		dodoc README
		docinto html
		dodoc -r doc/html/.

	fi
	if use examples ; then
		insinto "/usr/share/${P}/examples"
		doins *.c
		exeinto "/usr/libexec/${P}"
		doexe example-buffer
		doexe example-codelock
		doexe example-small
	fi
}
