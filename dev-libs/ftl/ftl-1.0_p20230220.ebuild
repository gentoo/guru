# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

FORTRAN_STANDARD="2003"
inherit flag-o-matic fortran-2 toolchain-funcs

COMMIT="e19574fb309076550d7d6179273f63c79e236207"
DESCRIPTION="The Fortran Template Library (FTL) is a general purpose library for Fortran 2003"
HOMEPAGE="https://github.com/SCM-NV/ftl"
SRC_URI="https://github.com/SCM-NV/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="pcre test"
RESTRICT="!test? ( test )"
REQUIRED_USE="test? ( pcre )" # Some tests fail if 'pcre' is disabled

RDEPEND="pcre? ( dev-libs/libpcre:3 )"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

# Checking of supported fortran standard version is required here
pkg_setup() {
	fortran-2_pkg_setup
}

get_platform() {
	case $(tc-getFC) in
		*gfortran*) echo "gnu" ;;
		*ifort*) echo "intel" ;;
		*nagfor*) echo "nag" ;;
		*) die "Unsupported compiler: $(tc-getFC)" ;;
	esac
}

src_prepare() {
	default

	# Pass LDFLAGS to respect it
	sed -i '/SOLDFLAGS =/ s/$/ '"${LDFLAGS}"'/' makefile || die
}

src_configure() {
	filter-flags -fpch-preprocess
}

src_compile() {
	emake_args=(
		FC=$(tc-getFC)
		CXX=$(tc-getCXX)
		PLATFORM=$(get_platform)
		BUILD=custom
		USE_PCRE=$(usex pcre true false)
	)

	emake "${emake_args[@]}"
}

src_test() {
	emake_args=(
		FC=$(tc-getFC)
		CXX=$(tc-getCXX)
		PLATFORM=$(get_platform)
		BUILD=custom
		USE_PCRE=$(usex pcre true false)
	)

	emake "${emake_args[@]}" test
}

src_install() {
	# Set BUILD to custom as default type is debug
	emake BUILD=custom DESTDIR="${D}" PREFIX="${EPREFIX}"/usr LIBDIR=$(get_libdir) install
	einstalldocs
}
