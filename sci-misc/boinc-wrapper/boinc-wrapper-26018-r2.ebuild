# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools edo

DESCRIPTION="Wrapper to use non-BOINC apps with BOINC"
HOMEPAGE="https://boinc.berkeley.edu/trac/wiki/WrapperApp"
SRC_URI="https://github.com/BOINC/boinc/archive/refs/tags/wrapper/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Info-ZIP LGPL-3+ regexp-UofT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

DOCS=( job.xml )

PATCHES=( "${FILESDIR}"/${PN}-26018-sigstop.patch )

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
	emake -C samples/wrapper
}

src_install() {
	cd samples/wrapper || die

	einstalldocs
	newbin wrapper boinc-wrapper
}
