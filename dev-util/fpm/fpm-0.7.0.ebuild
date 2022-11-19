# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

FORTRAN_STANDARD="2003"

PYTHON_COMPAT=( python3_{8..10} )

inherit fortran-2 python-any-r1 toolchain-funcs

DESCRIPTION="Fortran Package Manager (fpm)"
HOMEPAGE="https://fpm.fortran-lang.org"
SRC_URI="
	https://github.com/fortran-lang/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/fortran-lang/fpm/releases/download/v${PV}/${P}.F90
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"
RESTRICT="test"

CDEPEND="
	dev-libs/toml-f
	dev-libs/m_cli2
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
			app-doc/ford[${PYTHON_USEDEP}]
		')
	)
"

DOCS=( LICENSE PACKAGING.md README.md )

PATCHES="${FILESDIR}/${P}_fpm_toml.patch"

BSDIR="build/bootstrap" # Bootstrap directory path

pkg_setup() {
	fortran-2_pkg_setup
	python-any-r1_pkg_setup
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
	"${BSDIR}"/fpm build --compiler "$(tc-getFC)" --flag "${FCFLAGS} -I/usr/include/toml-f -I/usr/include/m_cli2" \
		--c-compiler "$(tc-getCC)" --c-flag "${CFLAGS}" \
		--cxx-compiler "$(tc-getCXX)" --cxx-flag "${CXXFLAGS}" \
		--archiver="$(tc-getAR)" --link-flag "${LDFLAGS}"

	if use doc ; then
		einfo "Build API documentation:"
		ford docs.md || die
	fi
}

src_install() {
	exeinto /usr/bin
	doexe build/"$(tc-getFC)"_*/app/fpm

	use doc && HTML_DOCS=( "${S}"/fpm-doc/. )
	einstalldocs
}
