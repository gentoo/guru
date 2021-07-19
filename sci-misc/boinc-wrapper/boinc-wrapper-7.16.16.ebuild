# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

MY_PN=${PN%%-*}
MY_PV=$(ver_cut 1-2)
DESCRIPTION="Wrapper to use non-BOINC apps with BOINC"
HOMEPAGE="https://boinc.berkeley.edu/trac/wiki/WrapperApp"

SRC_URI="https://github.com/${MY_PN}/${MY_PN}/archive/client_release/${MY_PV}/${PV}.tar.gz -> ${MY_PN}-${PV}.tar.gz"
KEYWORDS="~amd64 ~arm64 ~x86"
S="${WORKDIR}/${MY_PN}-client_release-${MY_PV}-${PV}/samples/${PN#*-}"

LICENSE="LGPL-3+ regexp-UofT"
SLOT="0"

# sci-misc/boinc doesn't have all necessary headers, so
# we have to include from build root. All that said,
# versions must not mismatch.
RDEPEND="
	~sci-misc/boinc-${PV}
	>=dev-libs/boinc-zip-${PV}
"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}"/${PN}-$(ver_cut 1-2)-makefile.patch )
DOCS=( job.xml )

src_configure() {
	cd ../.. || die

	bash ./generate_svn_version.sh || die

	# autotools would take an eternity to configure
	cat <<-EOF > "config.h"
		#ifndef BOINC_CONFIG_H
		#define BOINC_CONFIG_H

		#define HAVE_SYS_RESOURCE_H 1
		#define HAVE_SYS_TIME_H 1
		#define HAVE_SYS_WAIT_H 1

		#endif
	EOF

	tc-export CC CXX
}

src_install() {
	einstalldocs
	newbin wrapper boinc-wrapper
}
