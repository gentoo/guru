# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_10 )

# Keep these revs up to date with the 'latest' submodule for each pdk lib in libraries/
# Build seems to fail if these lapse compared to the rev used by the skywater_pdk python module within this repo
MY_PN="skywater-pdk"
MY_REV=5a57f505cd4cd65d10e9f37dd2d259a526bc9bf7
MY_sky130_fd_io_REV=01b18699b4102d8e54ad1406b3991ecb652e5aee
MY_sky130_fd_pr_REV=f62031a1be9aefe902d6d54cddd6f59b57627436
MY_sky130_fd_pr_reram_REV=48c8310e464157d797c78cb2e6d6b5a21d710c20
MY_sky130_fd_sc_hd_REV=ac7fb61f06e6470b94e8afdf7c25268f62fbd7b1
MY_sky130_fd_sc_hdll_REV=0694bd23893de20f5233ef024acf6cca1e750ac6
MY_sky130_fd_sc_hs_REV=1d051f49bfe4e2fe9108d702a8bc2e9c081005a4
MY_sky130_fd_sc_hvl_REV=4fd4f858d16c558a6a488b200649e909bb4dd800
MY_sky130_fd_sc_lp_REV=e2c1e0646999163d35ea7b2521c3ec5c28633e63
MY_sky130_fd_sc_ls_REV=4f549e30dd91a1c264f8895e07b2872fe410a8c2
MY_sky130_fd_sc_ms_REV=ae1b7f68821505cf2d93d9d44cce5ece22710fad

inherit check-reqs python-any-r1

DESCRIPTION="Process design kit for usage with SkyWater Technology Foundry's 130nm node"
HOMEPAGE="https://github.com/google/skywater-pdk"
SRC_URI="
	https://github.com/google/skywater-pdk/archive/${MY_REV}.tar.gz -> ${P}.tar.gz
	https://github.com/google/skywater-pdk-libs-sky130_fd_io/archive/${MY_sky130_fd_io_REV}.tar.gz -> skywater-pdk-libs-sky130_fd_io-${MY_sky130_fd_io_REV}.tar.gz
	https://github.com/google/skywater-pdk-libs-sky130_fd_pr/archive/${MY_sky130_fd_pr_REV}.tar.gz -> skywater-pdk-libs-sky130_fd_pr-${MY_sky130_fd_pr_REV}.tar.gz
	https://github.com/google/skywater-pdk-libs-sky130_fd_pr_reram/archive/${MY_sky130_fd_pr_reram_REV}.tar.gz -> skywater-pdk-libs-sky130_fd_pr_reram-${MY_sky130_fd_pr_reram_REV}.tar.gz
	https://github.com/google/skywater-pdk-libs-sky130_fd_sc_hd/archive/${MY_sky130_fd_sc_hd_REV}.tar.gz -> skywater-pdk-libs-sky130_fd_sc_hd-${MY_sky130_fd_sc_hd_REV}.tar.gz
	https://github.com/google/skywater-pdk-libs-sky130_fd_sc_hdll/archive/${MY_sky130_fd_sc_hdll_REV}.tar.gz -> skywater-pdk-libs-sky130_fd_sc_hdll-${MY_sky130_fd_sc_hdll_REV}.tar.gz
	https://github.com/google/skywater-pdk-libs-sky130_fd_sc_hs/archive/${MY_sky130_fd_sc_hs_REV}.tar.gz -> skywater-pdk-libs-sky130_fd_sc_hs-${MY_sky130_fd_sc_hs_REV}.tar.gz
	https://github.com/google/skywater-pdk-libs-sky130_fd_sc_hvl/archive/${MY_sky130_fd_sc_hvl_REV}.tar.gz -> skywater-pdk-libs-sky130_fd_sc_hvl-${MY_sky130_fd_sc_hvl_REV}.tar.gz
	https://github.com/google/skywater-pdk-libs-sky130_fd_sc_lp/archive/${MY_sky130_fd_sc_lp_REV}.tar.gz -> skywater-pdk-libs-sky130_fd_sc_lp-${MY_sky130_fd_sc_lp_REV}.tar.gz
	https://github.com/google/skywater-pdk-libs-sky130_fd_sc_ls/archive/${MY_sky130_fd_sc_ls_REV}.tar.gz -> skywater-pdk-libs-sky130_fd_sc_ls-${MY_sky130_fd_sc_ls_REV}.tar.gz
	https://github.com/google/skywater-pdk-libs-sky130_fd_sc_ms/archive/${MY_sky130_fd_sc_ms_REV}.tar.gz -> skywater-pdk-libs-sky130_fd_sc_ms-${MY_sky130_fd_sc_ms_REV}.tar.gz
"
S="${WORKDIR}/${PN}-${MY_REV}"

LICENSE="Apache-2.0"
SLOT="0/0.0.0.20220424"
KEYWORDS="~amd64"

BDEPEND="
	${PYTHON_DEPS}
	$(python_gen_any_dep 'dev-python/python-skywater-pdk[${PYTHON_USEDEP}]')
"

# Extremely large liberty files are required by sci-electronics/open_pdk
CHECKREQS_DISK_BUILD="42G"
CHECKREQS_DISK_USR="21G"

src_unpack() {
	unpack ${A}

	# Move the libraries in place to their corresponding submodules
	for lib in sky130_fd_{io,pr,pr_reram,sc_hd,sc_hdll,sc_hs,sc_hvl,sc_lp,sc_ls,sc_ms}; do
		rmdir "${S}/libraries/${lib}/"* || die
		mv -f "${WORKDIR}"/skywater-pdk-libs-${lib}-* "${S}/libraries/${lib}/latest" || die
	done
}

src_compile() {
	for lib in libraries/sky130_*_sc_*/latest; do
		if [[ -d $lib/cells ]]; then
			${EPYTHON} -m skywater_pdk.liberty $lib || die
			${EPYTHON} -m skywater_pdk.liberty $lib all || die
			${EPYTHON} -m skywater_pdk.liberty $lib all --ccsnoise || die
		fi
	done

	for lib in libraries/sky130_fd_sc_ms/latest; do
		if [[ -d $lib/cells ]]; then
			${EPYTHON} -m skywater_pdk.liberty $lib all --leakage || die
		fi
	done
}

src_install() {
	insinto "/usr/share/pdk/skywater-pdk-source/libraries"
	for lib in sky130_fd_{io,pr,pr_reram,sc_hd,sc_hdll,sc_hs,sc_hvl,sc_lp,sc_ls,sc_ms}; do
		doins -r "${S}/libraries/${lib}"
	done
}
