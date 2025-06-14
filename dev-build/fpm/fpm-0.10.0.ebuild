# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

FORTRAN_STANDARD="2003"

PYTHON_COMPAT=( python3_{11..12} )

inherit fortran-2 python-any-r1 toolchain-funcs

DESCRIPTION="Fortran Package Manager (fpm)"
HOMEPAGE="https://fpm.fortran-lang.org"
SRC_URI="
	https://github.com/fortran-lang/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/fortran-lang/fpm/releases/download/v${PV}/${P}.F90
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="openmp doc test"
RESTRICT="!test? ( test )"

CDEPEND="
	dev-libs/fortran-regex
	dev-libs/fortran-shlex:0/1
	dev-libs/jonquil:0/2
	dev-libs/toml-f:0/4
	dev-libs/M_CLI2
"

RDEPEND="
	${CDEPEND}
	dev-vcs/git
"

DEPEND="
	${CDEPEND}
	doc? (
		${PYTHON_DEPS}
		$(python_gen_any_dep '
			app-text/ford[${PYTHON_USEDEP}]
		')
	)
"

DOCS=( LICENSE PACKAGING.md README.md )

PATCHES="${FILESDIR}/${P}_fpm_toml.patch"

BSDIR="build/bootstrap" # Bootstrap directory path

pkg_pretend() {
	[[ ${MERGE_TYPE} != binary ]] && use openmp && tc-check-openmp
}

set_build_flags() {
	OMPFLAG=""
	if use openmp ; then
		case $(tc-getFC) in
			*gfortran* )
				OMPFLAG="-fopenmp" ;;
			* )
				die "Sorry, only GNU gfortran is currently supported in the ebuild" ;;
		esac
	fi

	BUILD_FLAGS=( --compiler "$(tc-getFC)"
		--flag "${FCFLAGS} ${OMPFLAG} -I/usr/include/fortran-regex \
						-I/usr/include/fortran-shlex \
						-I/usr/include/jonquil/modules \
						-I/usr/include/M_CLI2 \
						-I/usr/include/toml-f/modules"
		--c-compiler "$(tc-getCC)" --c-flag "${CFLAGS}"
		--cxx-compiler "$(tc-getCXX)" --cxx-flag "${CXXFLAGS}"
		--archiver "$(tc-getAR)" --link-flag "${LDFLAGS}" )
}

pkg_setup() {
	[[ ${MERGE_TYPE} != binary ]] && use openmp && tc-check-openmp
	fortran-2_pkg_setup
	python-any-r1_pkg_setup
	set_build_flags
}

src_prepare() {
	default

	mkdir -p "${BSDIR}" || die
	cp "${DISTDIR}/${P}.F90" "${BSDIR}/" || die

	# Use favicon.png instead remote icon
	sed -i -e 's#https://fortran-lang.org/assets/img/fortran_logo_512x512.png#favicon.png#' docs.md || die
}

src_compile() {
	default

	# Build a bootstrap binary from the single source version
	"$(tc-getFC)" -J "${BSDIR}" -o "${BSDIR}"/fpm "${BSDIR}/${P}.F90" || die

	# Use the bootstrap binary to build the feature complete fpm version
	"${BSDIR}"/fpm build --verbose "${BUILD_FLAGS[@]}" || die

	if use doc ; then
		einfo "Build API documentation:"
		ford docs.md || die
	fi
}

src_test() {
	"${BSDIR}"/fpm test --verbose "${BUILD_FLAGS[@]}" || die
}

src_install() {
	# Set prefix and pass all used env flags to avoid recompiling with default values
		"${BSDIR}"/fpm install --prefix "${ED}/usr" "${BUILD_FLAGS[@]}" || die

	use doc && HTML_DOCS=( "${S}"/fpm-doc/. )
	einstalldocs
}
