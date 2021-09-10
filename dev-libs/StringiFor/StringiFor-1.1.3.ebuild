# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

FORTRAN_STANDARD=2003
PYTHON_COMPAT=( python3_{8..10} )

inherit  fortran-2 python-any-r1 toolchain-funcs

# Unfortunately the releases don't have appropriate release-tags
# so there commits sha-1 checksum are used
StringiFor_sha="bad95cb8c1ae0f17dd3e15acd6bc2a8cde4bb606"	# StringiFor-1.1.3 (18 jun 2021)
BeFoR64_sha="e222ede7f1207f74acafd30c6c6e1d3585b5bb74"		# BeFoR-1.1.4_p20201012 (12 oct 2020)
FACE_sha="748688899f73bcb0d2723f5c00e3d0fe13648167"		# FACE-1.1.2_p20201005 (5 oct 2020)
PENF_sha="b146a7d6444e0cd8a42a20452a7c4a4f4f16c667"		# PENF-1.2.2_20201012 (12 oct 2020)

DESCRIPTION="StringiFor, Strings Fortran Manipulator, yet another strings Fortran module"
HOMEPAGE="https://github.com/szaghi/StringiFor"
SRC_URI="
	https://github.com/szaghi/${PN}/archive/"${StringiFor_sha}".tar.gz -> ${P}.tar.gz
	https://github.com/szaghi/BeFoR64/archive/"${BeFoR64_sha}".tar.gz -> BeFoR64-1.1.4_p20201012.tar.gz
	https://github.com/szaghi/FACE/archive/"${FACE_sha}".tar.gz -> FACE-1.1.2_p20201005.tar.gz
	https://github.com/szaghi/PENF/archive/"${PENF_sha}".tar.gz -> PENF-1.2.2_p20201012.tar.gz
"

S="${WORKDIR}/${PN}-${StringiFor_sha}"

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
		dev-util/FoBiS[${PYTHON_USEDEP}]
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
	mv -T "${WORKDIR}"/BeFoR64-"${BeFoR64_sha}" "${S}"/src/third_party/BeFoR64 || die
	mv -T "${WORKDIR}"/FACE-"${FACE_sha}" "${S}"/src/third_party/FACE || die
	mv -T "${WORKDIR}"/PENF-"${PENF_sha}" "${S}"/src/third_party/PENF || die
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
