# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Lightweight, Stackless Threads in C"
HOMEPAGE="https://web.archive.org/web/20190923093100/http://dunkels.com/adam/pt/"
SRC_URI="
	https://web.archive.org/web/20190518175329/http://dunkels.com/adam/download/pt-${PV}.tar.gz -> ${P}.tar
	https://web.archive.org/web/20190518175329/http://dunkels.com/adam/download/graham-pt.h
"
S="${WORKDIR}/pt-${PV}"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="doc examples"

BDEPEND="doc? ( app-text/doxygen )"
PATCHES=(
	"${FILESDIR}/${P}-respect-cflags.patch"
	"${FILESDIR}/${P}-fix-clang-build.patch"
)

src_unpack() {
	default
	cp "${DISTDIR}/graham-pt.h" "${S}" || die
}

src_compile() {
	tc-export CC
	use examples && emake
	if use doc ; then
		pushd doc || die
		emake
	fi
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
		docompress -x "/usr/share/doc/${P}/html"
	fi
	if use examples ; then
		insinto "/usr/share/${P}/examples"
		doins *.c
		exeinto "/usr/libexec/${PN}"
		doexe example-buffer
		doexe example-codelock
		doexe example-small
	fi
}
