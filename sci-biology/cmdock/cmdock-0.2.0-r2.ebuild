# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..12} )
BOINC_APP_OPTIONAL=1
inherit boinc-app flag-o-matic meson optfeature python-any-r1

DESCRIPTION="Program for docking ligands to proteins and nucleic acids"
HOMEPAGE="https://gitlab.com/Jukic/cmdock"
SRC_URI="https://gitlab.com/Jukic/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.bz2"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="LGPL-3 ZLIB"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="apidoc cpu_flags_x86_sse2 doc test"

# Flaky tests
RESTRICT="test"

DEPEND="
	dev-cpp/eigen:3
	>=dev-cpp/indicators-2.3-r1
	>=dev-cpp/pcg-cpp-0.98.1_p20210406-r1
	>=dev-libs/cxxopts-3
"
BDEPEND="
	apidoc? (
		app-text/doxygen
		dev-texlive/texlive-fontutils
	)
	doc? (
		$(python_gen_any_dep '
			dev-python/insipid-sphinx-theme[${PYTHON_USEDEP}]
			dev-python/sphinx[${PYTHON_USEDEP}]
		')
	)
	test? ( ${PYTHON_DEPS} )
"

PATCHES=(
	"${FILESDIR}"/${P}-include.patch
	"${FILESDIR}"/${P}-cxxopts.patch
)

DOCS=( README.md changelog.md )

BOINC_MASTER_URL="https://www.sidock.si/sidock/"
BOINC_INVITATION_CODE="Crunch_4Science"
BOINC_APP_HELPTEXT=\
"The easiest way to do something useful with this application
is to attach it to SiDock@home BOINC project."

INSTALL_PREFIX="${EPREFIX}/opt/${P}"

boinc-app_add_deps

python_check_deps() {
	use doc || return 0

	python_has_version "dev-python/sphinx[${PYTHON_USEDEP}]" &&
	python_has_version "dev-python/insipid-sphinx-theme[${PYTHON_USEDEP}]"
}

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
		--prefix="${INSTALL_PREFIX:?}"
		$(meson_use apidoc)
		$(meson_use doc)
		$(meson_use test tests)
		-Ddocdir="${EPREFIX}"/usr/share/doc/${PF}
	)
	meson_src_configure

	use cpu_flags_x86_sse2 || append-cppflags "-DBUNDLE_NO_SSE"
}

src_install() {
	meson_src_install
	python_optimize "${D}${INSTALL_PREFIX:?}"/bin

	if use boinc; then
		boinc_install_appinfo "${FILESDIR}"/app_info_0.2.0-r1.xml
		boinc_install_wrapper cmdock-l_wrapper \
			"${FILESDIR}"/cmdock-l_job_0.2.0-r1.xml cmdock-l_job.xml

		# install cmdock executable
		exeinto "$(get_project_root)"
		exeopts --owner root --group boinc
		doexe "${D}${INSTALL_PREFIX:?}"/bin/cmdock

		# install a blank file
		insinto "$(get_project_root)"
		insopts -m 0644 --owner root --group boinc
		newins - docking_out
	fi
}

pkg_postinst() {
	optfeature "sdtether.py and sdrmsd.py scripts" "dev-python/numpy sci-chemistry/openbabel[python]"
	use boinc && boinc-app_pkg_postinst
}

pkg_postrm() {
	use boinc && boinc-app_pkg_postrm
}
