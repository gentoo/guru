# Copyright 2021-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools edo

DESCRIPTION="Wrapper to use non-BOINC apps with BOINC"
HOMEPAGE="https://github.com/BOINC/boinc/wiki/WrapperApp"
SRC_URI="https://github.com/BOINC/boinc/archive/refs/tags/wrapper/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Info-ZIP LGPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

RDEPEND="
	dev-libs/libzip:=
	sys-libs/zlib:=
"
DEPEND="${RDEPEND}"

DOCS=( job.xml )

PATCHES=(
	"${FILESDIR}"/${PN}-26018-makefile.patch
)

QA_CONFIG_IMPL_DECL_SKIP=(
	# https://bugs.gentoo.org/922046
	"_mm*"
)

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	edo bash generate_svn_version.sh

	local myeconfargs=(
		# build libraries only
		--enable-pkg-devel
		--disable-fcgi

		# link with libboinc_api statically
		--disable-shared
		--enable-static

		# do not build libboinc_graphics
		--without-x
		ax_cv_check_gl_libgl=no
	)
	econf "${myeconfargs[@]}"
}

src_compile() {
	emake

	local wrapper_make_args=(
		MAKEFILE_LDFLAGS="-lpthread"
		MAKEFILE_STDLIB=
		WRAPPER_RELEASE_SUFFIX=
	)
	emake -C samples/wrapper "${wrapper_make_args[@]}"
}

src_install() {
	cd samples/wrapper || die

	einstalldocs
	newbin wrapper boinc-wrapper
}
