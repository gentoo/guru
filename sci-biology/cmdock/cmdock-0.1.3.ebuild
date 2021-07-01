# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} pypy3 )
DOCS_BUILDER="sphinx"
DOCS_AUTODOC=0
DOCS_DIR="docs"
inherit python-any-r1 docs meson

DESCRIPTION="Program for docking ligands to proteins and nucleic acids"
HOMEPAGE="https://gitlab.com/Jukic/cmdock"
SRC_URI="https://gitlab.com/Jukic/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.gz"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="LGPL-3"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="boinc"

RDEPEND="
	dev-lang/perl
	boinc? ( sci-misc/boinc-wrapper )
"
BDEPEND="
	dev-cpp/eigen:3
	dev-cpp/indicators
	>=dev-cpp/pcg-cpp-0.98.1_p20210406-r1
	dev-libs/cxxopts
"

src_prepare() {
	default
	rm -r include/indicators || die
}

src_configure() {
	# very weird directory layout
	local emesonargs=(
		--prefix="${EPREFIX}/opt/cmdock-${PV}"
	)
	meson_src_configure
}

src_compile() {
	meson_src_compile
	docs_compile
}

src_install() {
	meson_src_install

	if use boinc ; then
		insinto /var/lib/boinc/projects/www.sidock.si_sidock
		newins "${FILESDIR}/app_info_${PV}.xml" app_info.xml
		doins "${FILESDIR}/cmdock-boinc-zcp_job_${PV}.xml"

		dosym -r /usr/bin/boinc-wrapper /var/lib/boinc/projects/www.sidock.si_sidock/cmdock-boinc-zcp_wrapper_${PV}
	fi
}

pkg_postinst() {
	if use boinc ; then
		touch /var/lib/boinc/projects/www.sidock.si_sidock/docking_out.sd || die
		elog
		elog "The easiest way to do something useful with this application"
		elog "is to attach it to SiDock@home BOINC project."
		elog
		elog "- Master URL: https://sidock.si/sidock/"
		elog "- Invitation code: Crunch_4Science"
	fi
}
