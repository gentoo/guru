# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

SIMPLEINI_COMMIT="67156f64b3447ce1eb81d6be44d29132fb49b70a"

DESCRIPTION="C++ library for reading/writing INI files"
HOMEPAGE="https://github.com/brofield/simpleini"
SRC_URI="https://github.com/brofield/simpleini/archive/${SIMPLEINI_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/simpleini-${SIMPLEINI_COMMIT}"

src_compile() {
	$(tc-getCC) ${CFLAGS} -c ConvertUTF.c -o ConvertUTF.o || die
	$(tc-getCC) -shared -fPIC ${LDFLAGS} ConvertUTF.o -o libsimpleini.so || die
}

src_install() {
	einstalldocs
	dolib.so libsimpleini.so

	insinto /usr/include/simpleini
	doins SimpleIni.h ConvertUTF.h
}
