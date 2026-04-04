# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
inherit cmake python-any-r1 linux-info

DESCRIPTION="Runtime for AIE and FPGA based platforms"
HOMEPAGE="https://github.com/amd/xdna-driver"

if [[ ${PV} == 999999 ]] ; then
	EGIT_REPO_URI="https://github.com/amd/xdna-driver.git"
	EGIT_SUBMODULES=(
		xrt
		xrt/src/runtime_src/aie-rt
		xrt/src/runtime_src/core/common/aiebu
		xrt/src/runtime_src/core/common/elf
		xrt/src/runtime_src/xdp
	)
	inherit git-r3

	BDEPEND="net-misc/wget"
else
	VTD_HASH=c79b5d21568a4ffa5b0612a8279b352fc4e1109a

	declare -A submodules
	submodules["xrt"]=https://github.com/Xilinx/XRT.git@4eb1f4392a012b4e6eca759762389c612537f7c7
	submodules["xrt/src/runtime_src/aie-rt"]=https://github.com/Xilinx/aie-rt.git@a8b0667133ea2851ce27793a1796c5968226d9af
	submodules["xrt/src/runtime_src/core/common/aiebu"]=https://github.com/Xilinx/aiebu.git@9065273e0c0a4ac5930fff904ac245cf38dd3087
	submodules["xrt/src/runtime_src/core/common/elf"]=https://github.com/serge1/ELFIO.git@f849001fc229c2598f8557e0df22866af194ef98

	SRC_URI="
		https://github.com/amd/xdna-driver/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
		https://github.com/Xilinx/VTD/raw/${VTD_HASH}/archive/strx/xrt_smi_strx.a -> xrt_smi_strx-${VTD_HASH:0:8}.a
		https://github.com/Xilinx/VTD/raw/${VTD_HASH}/archive/phx/xrt_smi_phx.a -> xrt_smi_phx-${VTD_HASH:0:8}.a
		https://github.com/Xilinx/VTD/raw/${VTD_HASH}/archive/npu3/xrt_smi_npu3.a -> xrt_smi_npu3-${VTD_HASH:0:8}.a
	"
	for k in "${!submodules[@]}"; do
		git_url="${submodules[$k]%@*}"
		commit_hash="${submodules[$k]#*@}"
		url_prefix="${git_url%.git}"
		SRC_URI+=" ${url_prefix}/archive/${commit_hash}.tar.gz -> ${url_prefix##*/}-${commit_hash:0:8}.tar.gz";
	done

	KEYWORDS="~amd64"
	S="${WORKDIR}/xdna-driver-${PV}"
fi

LICENSE="AMD-Binary-Only"
SLOT="0"

RESTRICT="bindist mirror strip"

RDEPEND="
	dev-util/xrt
	sys-apps/util-linux
"

# Mostly thowaway dependencies, not actually used in final lib...
DEPEND="
	sys-apps/util-linux
	dev-debug/systemtap
	dev-libs/boost
	dev-libs/opencl-icd-loader
	dev-libs/rapidjson
	dev-util/opencl-headers
	x11-libs/libdrm
"

BDEPEND+="
	${PYTHON_DEPS}
	$(python_gen_any_dep "
		dev-python/pybind11[\${PYTHON_USEDEP}]
	")
"

PATCHES=(
	"${FILESDIR}"/${PN}-0_p20251025-fix-clang.patch
)

CONFIG_CHECK="~AMD_IOMMU ~DRM_ACCEL"

python_check_deps() {
	python_has_version -b "dev-python/pybind11[${PYTHON_USEDEP}]"
}

src_unpack() {
	if [[ ${PV} == 999999 ]] ; then
		git-r3_src_unpack

		pushd "${S}" || die
		local VTD_HASH=$(grep -oP 'VTD/raw/\K[0-9a-f]+' tools/info.json | head -n1)
		[[ "${VTD_HASH}" == "" ]] && die "Failed to extract VTD hash"

		local VTD_FILES=(
			"https://github.com/Xilinx/VTD/raw/${VTD_HASH}/archive/strx/xrt_smi_strx.a"
			"https://github.com/Xilinx/VTD/raw/${VTD_HASH}/archive/phx/xrt_smi_phx.a"
			"https://github.com/Xilinx/VTD/raw/${VTD_HASH}/archive/npu3/xrt_smi_npu3.a"
		)

		mkdir -p amdxdna_bins/vtd_archives || die

		for url in "${VTD_FILES[@]}"; do
			if ! wget -nc "${url}" -O "amdxdna_bins/vtd_archives/${url##*/}"; then
				die "Fetching from ${url} failed"
			fi
		done

		popd || die
	else
		default

		pushd "${S}" || die
		for k in $(printf '%s\n' "${!submodules[@]}" | sort); do
			git_url="${submodules[$k]%@*}"
			commit_hash="${submodules[$k]#*@}"
			url_prefix="${git_url%.git}"
			rm -r "$k" || die
			ln -s "${WORKDIR}/${url_prefix##*/}-${commit_hash}" "$k" || die
		done

		# Sanity check for new versions
		local actual_vtd_hash=$(grep -oP 'VTD/raw/\K[0-9a-f]+' tools/info.json | head -n1)
		[[ "${actual_vtd_hash}" == "" ]] && die "Failed to extract VTD hash"
		[[ "${actual_vtd_hash}" != "${VTD_HASH}" ]] && \
			die "VTD hash mismatch, ebuild requested ${VTD_HASH} while package wants ${actual_vtd_hash}"

		mkdir -p amdxdna_bins/vtd_archives || die
		cp "${DISTDIR}/xrt_smi_strx-${VTD_HASH:0:8}.a" amdxdna_bins/vtd_archives/xrt_smi_strx.a || die
		cp "${DISTDIR}/xrt_smi_phx-${VTD_HASH:0:8}.a" amdxdna_bins/vtd_archives/xrt_smi_phx.a || die
		cp "${DISTDIR}/xrt_smi_npu3-${VTD_HASH:0:8}.a" amdxdna_bins/vtd_archives/xrt_smi_npu3.a || die
		popd || die
	fi
}

src_prepare() {
	sed -e "/Unknown Linux package flavor/ s/FATAL_ERROR/MESSAGE/" -i "CMake/pkg.cmake" || die

	sed -e "s/set (XRT_UPSTREAM 0)/set (XRT_UPSTREAM 1)/" -i xrt/src/CMake/settings.cmake || die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}"/usr
		-DSKIP_KMOD=1
		-DUMQ_HELLO_TEST=n
		-DPython3_EXECUTABLE="${PYTHON}"
		-Wno-dev
	)
	[[ ${PV} != 999999 ]] && mycmakeargs+=( -DCMAKE_DISABLE_FIND_PACKAGE_Git=ON )

	cmake_src_configure
}

src_install() {
	cmake_src_install

	insinto /usr/share/xrt/amdxdna/bins
	doins amdxdna_bins/vtd_archives/*

	# belongs to dev-util/xrt
	rm -rf "${ED}/bins" || die
}
