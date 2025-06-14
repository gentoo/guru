# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

FORTRAN_STANDARD="2003"

inherit fortran-2 toolchain-funcs

DESCRIPTION="Modern Fortran port of the tiny-regex-c library for regular expressions"
HOMEPAGE="https://github.com/perazz/fortran-shlex"
SRC_URI="https://github.com/perazz/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0/1"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RESTRICT="!test? ( test )"

src_compile() {
	$(tc-getFC) ${FCFLAGS} -fPIC -Wl,-soname,lib"${PN}".so.1 ${LDFLAGS} \
		-shared -o libfortran-shlex.so.1 src/shlex_module.f90 || die
}

src_test() {
	cp shlex_module.mod test/shlex_module.mod || die
	cp libfortran-shlex.so.1 test/libfortran-shlex.so.1 || die
	pushd ./test || die
	ln -s libfortran-shlex.so.1 libfortran-shlex.so || die
	$(tc-getFC) ${FCFLAGS} -fPIC ${LDFLAGS} -L. \
		-o tests shlex_test.f90 -lfortran-shlex || die
	export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:./
	./tests || die
	popd
}

src_install() {
	dolib.so libfortran-shlex.so.1
	dosym libfortran-shlex.so.1 /usr/$(get_libdir)/libfortran-shlex.so
	insinto /usr/include/"${PN}"
	doins shlex_module.mod
}
