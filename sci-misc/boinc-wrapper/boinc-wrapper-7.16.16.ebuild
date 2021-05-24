# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools toolchain-funcs

MY_PV=$(ver_cut 1-2)

DESCRIPTION="use non-BOINC apps with BOINC"
HOMEPAGE="https://boinc.berkeley.edu/trac/wiki/WrapperApp"

SRC_URI="https://github.com/BOINC/boinc/archive/client_release/${MY_PV}/${PV}.tar.gz -> boinc-${PV}.tar.gz"
KEYWORDS="~amd64 ~x86"
S="${WORKDIR}/boinc-client_release-${MY_PV}-${PV}/samples/wrapper"

LICENSE="LGPL-3+ regexp-UofT"
SLOT="0"

RDEPEND="
	~sci-misc/boinc-${PV}
	~dev-libs/boinc-zip-${PV}
"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}"/${PN}-$(ver_cut 1-2)-makefile.patch )
DOCS=( ReadMe.txt job.xml )

src_prepare() {
	default

	cd ../.. || die
	eautoreconf
	bash ./generate_svn_version.sh || die
}

src_configure() {
	cd ../.. || die
	econf --enable-pkg-devel --disable-static --disable-fcgi --without-x
}

src_compile() {
	tc-export CC CXX
	default
}

src_install() {
	default
	newbin wrapper boinc-wrapper
}
