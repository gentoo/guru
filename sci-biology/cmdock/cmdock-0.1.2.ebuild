# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} pypy3 )
DOCS_BUILDER="sphinx"
DOCS_AUTODOC=0
inherit python-r1 docs meson

DESCRIPTION="Program for docking ligands to proteins and nucleic acids"
HOMEPAGE="https://gitlab.com/Jukic/cmdock"
SRC_URI="https://gitlab.com/Jukic/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.gz"
S="${WORKDIR}/${PN}-v${PV}"
DOCS_DIR="${S}/docs"

LICENSE="LGPL-3"
SLOT="${PV}"
KEYWORDS="~amd64"
IUSE="boinc"

DEPEND="
	dev-cpp/eigen
	dev-libs/cxxopts
	boinc? ( sci-misc/boinc-wrapper )
"
RDEPEND="${DEPEND}
	dev-lang/perl
"
BDEPEND="dev-cpp/pcg-cpp"

src_prepare() {
	default
	sed "s|pcg_cpp_dep = dependency.*|pcg_cpp_dep = declare_dependency(include_directories: '/usr/include')|" -i meson.build || die
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
		doins "${FILESDIR}/app_config.xml"
		doins "${FILESDIR}/cmdock-boinc_job_${PV}.xml"
		doins "${FILESDIR}/cmdock-boinc-zip_job_${PV}.xml"

		dosym "${EPREFIX}"/usr/bin/boinc-wrapper "/var/lib/boinc/projects/www.sidock.si_sidock/cmdock-wrapper_${PV}"
		dosym "${EPREFIX}"/usr/bin/boinc-wrapper "/var/lib/boinc/projects/www.sidock.si_sidock/cmdock-boinc-zip_wrapper_${PV}"
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
