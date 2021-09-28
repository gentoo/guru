# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

SIMPLEINI_COMMIT="7bca74f6535a37846162383e52071f380c99a43a"

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
