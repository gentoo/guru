# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

FORTRAN_STANDARD="2003"

inherit fortran-2 toolchain-funcs

m_cli2_sha="90a1a146e19c8ad37b0469b8cbd04bc28eb67a50"

DESCRIPTION="M_CLI2 - parse Unix-like command line arguments from Fortran"
HOMEPAGE="https://github.com/urbanjost/M_CLI2"
SRC_URI="https://github.com/urbanjost/M_CLI2/archive/${m_cli2_sha}.tar.gz -> ${P}.tar.gz"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RESTRICT="!test? ( test )"

S="${WORKDIR}/M_CLI2-${m_cli2_sha}/src"

src_prepare() {
	default

#	# Set Fortran FLAGS
	sed -i -e 's/F90FLAGS := .*$/F90FLAGS := '"${FCFLAGS}"' -fPIC/' Makefile || die
}

src_compile() {
	case $(tc-getFC) in
		*gfortran* )
			emake clean
			emake F90=$(tc-getFC) gfortran
			$(tc-getFC) -Wl,-soname,lib"${PN}".so.1 ${LDFLAGS} -shared -o lib"${PN}".so.1 M_CLI2.o;;
		* )
			die "Sorry, only GNU gfortran is currently supported in the ebuild" ;;
	esac
}

src_test() {
	emake test
}

src_install() {
	insinto "/usr/include/${PN}"
	doins "${PN}.mod"
	dolib.so "lib${PN}.so.1"
	dosym  "lib${PN}.so.1" "/usr/$(get_libdir)/lib${PN}.so"
}
