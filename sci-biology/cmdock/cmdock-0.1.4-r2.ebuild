# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} )
BOINC_APP_OPTIONAL="true"
DOCS_BUILDER="sphinx"
DOCS_AUTODOC=0
inherit python-single-r1 boinc-app docs flag-o-matic meson optfeature

DESCRIPTION="Program for docking ligands to proteins and nucleic acids"
HOMEPAGE="https://gitlab.com/Jukic/cmdock"
SRC_URI="https://gitlab.com/Jukic/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.bz2"
S="${WORKDIR}/${PN}-v${PV}"
INSTALL_PREFIX="${EPREFIX}/opt/${P}"

LICENSE="LGPL-3 ZLIB"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="apidoc boinc cpu_flags_x86_sse2"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}
	dev-lang/perl:*
	boinc? ( sci-misc/boinc-wrapper )
"
DEPEND="
	dev-cpp/eigen:3
	dev-cpp/indicators
	>=dev-cpp/pcg-cpp-0.98.1_p20210406-r1
	dev-libs/cxxopts
"
BDEPEND="
	apidoc? (
		app-doc/doxygen
		dev-texlive/texlive-fontutils
	)
"

PATCHES=( "${FILESDIR}"/cmdock-0.1.4-fix-detection.patch )

DOCS=( INSTALL.md README.md )

BOINC_MASTER_URL="https://www.sidock.si/sidock/"
BOINC_INVITATION_CODE="Crunch_4Science"
BOINC_APP_HELPTEXT=\
"The easiest way to do something useful with this application
is to attach it to SiDock@home BOINC project."

foreach_wrapper_job() {
	sed -e "s:@PREFIX@:${INSTALL_PREFIX}:g" -i "${1}" || die
}

src_prepare() {
	default
	python_fix_shebang "${S}"/bin
}

src_configure() {
	# very weird directory layout
	local emesonargs=(
		--prefix="${EPREFIX}/opt/${P}"
	)
	meson_src_configure

	use cpu_flags_x86_sse2 || append-cppflags "-DBUNDLE_NO_SSE"
}

src_compile() {
	meson_src_compile

	if use doc; then
		DOCS_DIR="docs"
		sphinx_compile
	fi

	if use apidoc; then
		DOCS_BUILDER="doxygen"
		DOCS_DIR="docs"
		doxygen_compile
	fi
}

src_install() {
	meson_src_install
	python_optimize "${ED}"/opt/${P}/

	if use boinc; then
		doappinfo "${FILESDIR}"/app_info_${PV}.xml
		dowrapper ${PN}-boinc-zcp

		# install a blank file
		touch "${T}"/docking_out || die
		insinto $(get_project_root)
		insopts -m 0644 --owner root --group boinc
		doins "${T}"/docking_out
	fi
}

pkg_postinst() {
	optfeature "sdtether.py and sdrmsd.py scripts" "dev-python/numpy sci-chemistry/openbabel[python]"
	use boinc && boinc-app_pkg_postinst
}

pkg_postrm() {
	use boinc && boinc-app_pkg_postrm
}
