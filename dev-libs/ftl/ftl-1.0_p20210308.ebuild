# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

FORTRAN_STANDARD="2003"

inherit fortran-2 toolchain-funcs

COMMIT="97b8292e893ad147ca44e42bcd56d23e9a8259fb"
DESCRIPTION="The Fortran Template Library (FTL) is a general purpose library for Fortran 2003"
HOMEPAGE="https://github.com/SCM-NV/ftl/"
SRC_URI="https://github.com/SCM-NV/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="pcre test"
RESTRICT="!test? ( test )"
REQUIRED_USE="test? ( pcre )" # Some tests fail if 'pcre' is disabled

S="${WORKDIR}/${PN}-${COMMIT}"

RDEPEND="
	pcre? ( dev-libs/libpcre )
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

pkg_setup() {
	fortran-2_pkg_setup
}

src_prepare() {
	default

	# Replase install PREFIX, LIBDIR, add library soname
	sed -i -e 's:PREFIX ?= /usr/local:PREFIX ?= '"${ED}"'/usr/:' \
		-e 's:(PREFIX)/lib:(PREFIX)/'"$(get_libdir)"':' \
		-e 's:SOLDFLAGS = -shared:SOLDFLAGS = -shared -Wl,-soname=libftl.so.1 '"${LDFLAGS}"':' makefile || die
}

src_configure() {
	return 0
}

src_compile() {
	emake \
		BUILD=release \
		USE_PCRE=$(usex pcre true false) \
		COMPILER="$(tc-getFC)" \
		FLAGS="${FCFLAGS}" \
		CXXCOMPILER="$(tc-getCXX)" \
		CXXFLAGS="${CXXFLAGS}"
}

src_test() {
	emake test
}

src_install() {
	emake install

	mv "${ED}/usr/$(get_libdir)"/libftl.so{,.1} || die
	dosym libftl.so.1 /usr/$(get_libdir)/libftl.so
}
