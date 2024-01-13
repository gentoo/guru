# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DOCS_BUILDER="sphinx"
DOCS_DEPEND="
	dev-python/breathe
	dev-python/sphinx-rtd-theme
"
DOCS_DIR="${S}/docs/source"
FORTRAN_NEEDED="fortran"
PYTHON_COMPAT=( python3_10 pypy3 )

inherit cmake python-any-r1 docs fortran-2

DESCRIPTION="Fault Tolerance Interface"
HOMEPAGE="https://github.com/leobago/fti"
SRC_URI="https://github.com/leobago/fti/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc examples fi-io hdf5 fortran openssl sionlib test tutorial"

#TODO: unbundle jerasure bpp iniparser
RDEPEND="
	sys-libs/zlib
	virtual/mpi

	hdf5? ( sci-libs/hdf5[mpi] )
	openssl? ( dev-libs/openssl )
	sionlib? ( sys-cluster/sionlib )
"
DEPEND="${RDEPEND}"
BDEPEND="doc? ( app-text/doxygen )"

PATCHES=(
	"${FILESDIR}/${PN}-sionlib-includedir.patch"
	"${FILESDIR}/${PN}-add-spinx-ext-autodoc.patch"
)
#RESTRICT="!test? ( test )"
RESTRICT="test"

pkg_setup() {
	fortran-2_pkg_setup
}

src_configure() {
	local mycmakeargs=(
		-DSIONLIBBASE="${EPREFIX}/usr/$(get_libdir)"
		-DENABLE_COVERAGE=OFF
		-DENABLE_IME_NATIVE=OFF

		-DENABLE_DOCU=$(usex doc)
		-DENABLE_EXAMPLES=$(usex examples)
		-DENABLE_FI_IO=$(usex fi-io)
		-DENABLE_FORTRAN=$(usex fortran)
		-DENABLE_HDF5=$(usex hdf5)
		-DENABLE_OPENSSL=$(usex openssl)
		-DENABLE_SIONLIB=$(usex sionlib)
		-DENABLE_TESTS=$(usex test)
		-DENABLE_TUTORIAL=$(usex tutorial)
	)
	cmake_src_configure
}

src_compile() {
	cmake_src_compile
	docs_compile
}

src_install() {
	cmake_src_install
	einstalldocs
	if use examples; then
		mkdir -p "${ED}/usr/libexec/${PN}" || die
		mv "${ED}/usr/bin/examples" "${ED}/usr/libexec/${PN}/examples" || die
	fi
	if use tutorial; then
		mkdir -p "${ED}/usr/libexec/${PN}" || die
		mv "${ED}/usr/bin/tutorial" "${ED}/usr/libexec/${PN}/tutorial" || die
	fi
	find "${ED}" -name '*.a' -delete || die
}
