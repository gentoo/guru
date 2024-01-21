# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

FORTRAN_STANDARD=2003
PYTHON_COMPAT=( python3_{10..11} )

inherit  fortran-2 python-any-r1 toolchain-funcs

DESCRIPTION="StringiFor, Strings Fortran Manipulator, yet another strings Fortran module"
HOMEPAGE="https://github.com/szaghi/StringiFor"
SRC_URI="https://github.com/szaghi/StringiFor/releases/download/v${PV}/StringiFor.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}"

# For FOSS projects: GPL-3
# For closed source/commercial projects: BSD 2-Clause, BSD 3-Clause, MIT
LICENSE="GPL-3 BSD-2 BSD MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="static-libs test"
RESTRICT="!test? ( test )"

BDEPEND="
	${PYTHON_DEPS}
	$(python_gen_any_dep '
		dev-build/FoBiS[${PYTHON_USEDEP}]
	')
"

PATCHES=(
	"${FILESDIR}/stringifor-1.1.1_fobos_soname.patch"
	"${FILESDIR}/stringifor-1.1.3_fix_tests.patch"
)

set_build_mode() {
	case $(tc-getFC) in
		*gfortran* )
			BUILD_MODE_SHARED="-mode stringifor-shared-gnu"
			BUILD_MODE_STATIC="-mode stringifor-static-gnu"
			BUILD_MODE_TESTS="-mode tests-gnu" ;;
		*ifort* )
			BUILD_MODE_SHARED="-mode stringifor-shared-intel"
			BUILD_MODE_STATIC="-mode stringifor-static-intel"
			BUILD_MODE_TESTS="-mode tests-intel" ;;
		* )
			die "Sorry, GNU gfortran or Intel ifort are currently supported in the ebuild" ;;
	esac
}

pkg_setup() {
	fortran-2_pkg_setup
	set_build_mode
}

src_prepare() {
	default

	sed -i -e 's:\$OPTIMIZE    = -O2:\$OPTIMIZE    = '"${FFLAGS}"':' \
		-e '/^\$LSHARED/s:$: '"${LDFLAGS}"':' fobos || die
}

src_compile() {
	${EPYTHON} FoBiS.py build -verbose -compiler custom -fc $(tc-getFC) ${BUILD_MODE_SHARED} || die
	use static-libs && { ${EPYTHON} FoBiS.py build -verbose -compiler custom -fc $(tc-getFC) ${BUILD_MODE_STATIC} || die; }
}

src_test() {
	${EPYTHON} FoBiS.py build -compiler custom -fc $(tc-getFC) ${BUILD_MODE_TESTS} || die
	for e in $( find ./exe/ -type f -executable -print ); do
		if [ "$e" != "./exe/stringifor_test_parse_large_csv" ] ; then
			echo "  run test $e :" && { $e || die; }
		else
			# The output of this test is too huge so it's cutted here
			echo "  run test $e :" && { $e | tail -n 10 || die; }
		fi
	done
}

src_install() {
	mv lib/mod lib/stringifor || die
	doheader -r lib/stringifor/

	mv lib/libstringifor.so{,.1} || die
	dosym libstringifor.so.1 /usr/$(get_libdir)/libstringifor.so
	dolib.so lib/libstringifor.so.1

	use static-libs && dolib.a lib/libstringifor.a
}
