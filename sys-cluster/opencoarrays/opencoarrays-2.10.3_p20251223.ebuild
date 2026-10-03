# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_MAKEFILE_GENERATOR=emake
FORTRAN_STANDARD="2003"

inherit cmake flag-o-matic fortran-2

MY_PN="OpenCoarrays"
MY_PV="${PV%_*}"

DESCRIPTION="A parallel application binary interface for Fortran 2018 compilers"
HOMEPAGE="http://www.opencoarrays.org/"
SRC_URI="https://github.com/sourceryinstitute/${MY_PN}/archive/refs/tags/${MY_PV}.tar.gz -> ${MY_PN}-${PV}.tar.gz"

S="${WORKDIR}/${MY_PN}-${MY_PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# Tests fail with FEATURES="network-sandbox" for most versions of openmpi and mpich it with error:
# "No network interfaces were found for out-of-band communications.
#  We require at least one available network for out-of-band messaging."
IUSE="static-libs test"
PROPERTIES="test_network"
RESTRICT="!test? ( test )"

# >=sys-cluster/openmpi-4.1.2[fortran] is dropped due to
# multiple test failures issue:
# https://github.com/sourceryinstitute/OpenCoarrays/issues/769
RDEPEND="
	>=sys-cluster/mpich-3.4.3[fortran,mpi-threads,threads]
"
DEPEND="
	${RDEPEND}
"

PATCHES=(
	"${FILESDIR}/${PN}-${MY_PV}_patch_01_Improve_teams_implementation.patch"
	"${FILESDIR}/${PN}-${MY_PV}_patch_02_Fix_team_number.patch"
	"${FILESDIR}/${PN}-${MY_PV}_patch_03_Remove_wrong_error.patch"
	"${FILESDIR}/${PN}-${MY_PV}_patch_04_Enchance_debug_logging.patch"
	"${FILESDIR}/${PN}-${MY_PV}_patch_05_Add_owning_memory_flag.patch"
	"${FILESDIR}/${PN}-${MY_PV}_patch_06_Keep_team_translate_rework.patch"
	"${FILESDIR}/${PN}-${MY_PV}_patch_07_Use_COMM_TEAM_instead_of_COMM_WORLD.patch"
	"${FILESDIR}/${PN}-${MY_PV}_patch_08_Add_more_beefy_tests.patch"
	"${FILESDIR}/${PN}-${MY_PV}_patch_09_Add_comments_to_teams_num_images_test.patch"
	"${FILESDIR}/${PN}-${MY_PV}_patch_10_Fixes_for_use_with_gcc_lt_16.patch"
	"${FILESDIR}/${PN}-${MY_PV}_patch_11_Ensure_gcc-16_compatibility.patch"
	"${FILESDIR}/${PN}-${MY_PV}_patch_12_Fix_teams_testcase.patch"
)

src_configure() {
	filter-lto # Bug 860765

	cmake_src_configure
}

src_install() {
	cmake_src_install

	if ! use static-libs ; then
		find "${ED}" -name '*.a' -delete || die # Bug 901423
	fi
}
