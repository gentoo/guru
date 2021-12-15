# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

FORTRAN_STANDARD="2003"
PYTHON_COMPAT=( python3_{8..9} )

inherit cmake fortran-2 python-any-r1

MY_PN="stdlib"
SRC_URI="https://github.com/fortran-lang/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

DESCRIPTION="A community driven standard library for (modern) Fortran"
HOMEPAGE="https://stdlib.fortran-lang.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"
RESTRICT="mirror !test? ( test )"

S="${WORKDIR}/${MY_PN}-${PV}"

DEPEND="
	${PYTHON_DEPS}
	$(python_gen_any_dep '
		dev-util/fypp[${PYTHON_USEDEP}]
	')
	doc? (
		$(python_gen_any_dep '
			app-doc/ford[${PYTHON_USEDEP}]
		')
	)
"

pkg_setup() {
	fortran-2_pkg_setup
}

src_configure() {
	local mycmakeargs+=(
		-DBUILD_SHARED_LIBS=on
	)
	cmake_src_configure
}

src_compile() {
	cmake_src_compile

	if use doc ; then
		einfo "Build API documentation:"
		${EPYTHON} ford API-doc-FORD-file.md || die
	fi
}

src_install() {
	cmake_src_install

	use doc && HTML_DOCS=( "${WORKDIR}/${MY_PN}-${PV}"/API-doc/. )
	einstalldocs
}
