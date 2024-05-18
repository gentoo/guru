# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

FORTRAN_STANDARD="2003"

inherit fortran-2 toolchain-funcs

DESCRIPTION="Modern Fortran port of the tiny-regex-c library for regular expressions"
HOMEPAGE="https://github.com/perazz/fortran-regex"
SRC_URI="https://github.com/perazz/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RESTRICT="!test? ( test )"

src_compile() {
	$(tc-getFC) ${FCFLAGS} -fPIC -Wl,-soname,lib"${PN}".so.1 ${LDFLAGS} \
		-shared -o libfortran-regex.so.1 src/regex.f90 || die
}

src_test() {
	cp regex_module.mod test/regex_module.mod || die
	cp libfortran-regex.so.1 test/libfortran-regex.so.1 || die
	pushd ./test || die
	ln -s libfortran-regex.so.1 libfortran-regex.so || die
	$(tc-getFC) ${FCFLAGS} -fPIC ${LDFLAGS} -L. \
		-o tests test_1.f90 test_2.f90 test_m_regex.f90 tests.f90 -lfortran-regex || die
	export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:./
	./tests || die
	popd
}

src_install() {
	dolib.so libfortran-regex.so.1
	dosym libfortran-regex.so.1 /usr/$(get_libdir)/libfortran-regex.so
	insinto /usr/include/"${PN}"
	doins regex_module.mod
}
