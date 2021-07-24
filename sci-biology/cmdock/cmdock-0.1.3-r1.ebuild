# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} pypy3 )

BOINC_APP_OPTIONAL="true"

DOCS_BUILDER="sphinx"
DOCS_AUTODOC=0
DOCS_DIR="docs"

inherit python-any-r1 boinc-app docs meson

DESCRIPTION="Program for docking ligands to proteins and nucleic acids"
HOMEPAGE="https://gitlab.com/Jukic/cmdock https://www.rxdock.org"
SRC_URI="https://gitlab.com/Jukic/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.gz"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="LGPL-3"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="apidoc boinc"
REQUIRED_USE="apidoc? ( doc )"

RDEPEND="
	dev-lang/perl
	boinc? ( sci-misc/boinc-wrapper )
"
BDEPEND="
	dev-cpp/eigen:3
	dev-cpp/indicators
	>=dev-cpp/pcg-cpp-0.98.1_p20210406-r1
	dev-libs/cxxopts
	apidoc? ( app-doc/doxygen )
"

DOCS=( INSTALL.md README.md )

BOINC_MASTER_URL="https://www.sidock.si/sidock/"
BOINC_INVITATION_CODE="Crunch_4Science"
BOINC_APP_HELPTEXT=\
"The easiest way to do something useful with this application
is to attach it to SiDock@home BOINC project."

foreach_wrapper_job() {
	sed -i "$1" \
		-e "s:@PREFIX@:${EPREFIX}/opt/${P}:g" || die
}

src_prepare() {
	default
	rm -r include/indicators || die
}

src_configure() {
	# very weird directory layout
	local emesonargs=(
		--prefix="${EPREFIX}/opt/${P}"
	)
	meson_src_configure
}

src_compile() {
	meson_src_compile

	# subshell prevents from overriding global
	# DOCS_BUILDER and DOCS_OUTDIR
	use apidoc && (
		DOCS_BUILDER="doxygen"
		DOCS_OUTDIR="${S}/_build/html/api"
		docs_compile
	)
	docs_compile
}

src_install() {
	meson_src_install

	if use boinc; then
		doappinfo "${FILESDIR}"/app_info_${PV}.xml
		dowrapper ${PN}-boinc-zcp

		# install a blank file
		insinto $(get_project_root)
		insopts --owner boinc --group boinc
		: newins - docking_out.sd
	fi
}

pkg_postinst() {
	use boinc && boinc-app_pkg_postinst
}

pkg_postrm() {
	use boinc && boinc-app_pkg_postrm
}
