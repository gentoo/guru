# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PV_HASH=09824b1cff30cd3fcb657154188e6ddab708e2ec

PYTHON_COMPAT=( python3_{11..14} )
inherit cmake python-any-r1 linux-info

declare -A submodules
submodules["xrt"]=https://github.com/Xilinx/XRT.git@e2ce7d539b6974c7b39620ce1cda2851c9abca5a
submodules["xrt/src/runtime_src/aie-rt"]=https://github.com/Xilinx/aie-rt.git@a8b0667133ea2851ce27793a1796c5968226d9af
submodules["xrt/src/runtime_src/core/common/aiebu"]=https://github.com/Xilinx/aiebu.git@9065273e0c0a4ac5930fff904ac245cf38dd3087
submodules["xrt/src/runtime_src/core/common/elf"]=https://github.com/serge1/ELFIO.git@f849001fc229c2598f8557e0df22866af194ef98

DESCRIPTION="Runtime for AIE and FPGA based platforms"
HOMEPAGE="https://github.com/amd/xdna-driver"

VTD_HASH=5f7fec23620be7a3984c8970bc514f0faa2b2ee3

if [[ ${PV} == 999999 ]] ; then
	EGIT_REPO_URI="https://github.com/amd/xdna-driver.git"
	EGIT_SUBMODULES=(
		xrt
		xrt/src/runtime_src/aie-rt
		xrt/src/runtime_src/core/common/aiebu
		xrt/src/runtime_src/core/common/elf
	)
	inherit git-r3
else
	SRC_URI="
		https://github.com/amd/xdna-driver/archive/${PV_HASH}.tar.gz -> ${P}.tar.gz
	"
	for k in "${!submodules[@]}"; do
		git_url="${submodules[$k]%@*}"
		commit_hash="${submodules[$k]#*@}"
		url_prefix="${git_url%.git}"
		SRC_URI+=" ${url_prefix}/archive/${commit_hash}.tar.gz -> ${url_prefix##*/}-${commit_hash:0:8}.tar.gz";
	done

	KEYWORDS="~amd64"
	S="${WORKDIR}/xdna-driver-${PV_HASH}"
fi

SRC_URI+="
	https://github.com/Xilinx/VTD/raw/${VTD_HASH}/archive/strx/xrt_smi_strx.a -> xrt_smi_strx-${VTD_HASH:0:8}.a
	https://github.com/Xilinx/VTD/raw/${VTD_HASH}/archive/phx/xrt_smi_phx.a -> xrt_smi_phx-${VTD_HASH:0:8}.a
"

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

BDEPEND="
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

src_prepare() {
	if [[ ${PV} != 999999 ]] ; then
		for k in $(printf '%s\n' "${!submodules[@]}" | sort); do
			git_url="${submodules[$k]%@*}"
			commit_hash="${submodules[$k]#*@}"
			url_prefix="${git_url%.git}"
			rm -r "$k" || die
			ln -s "${WORKDIR}/${url_prefix##*/}-${commit_hash}" "$k" || die
		done
	fi

	# Check for new versions and live ebuild
	local actual_vtd_hash=$(grep -oP 'VTD/raw/\K[0-9a-f]+' CMake/pkg.cmake | head -n1)
	[[ "${actual_vtd_hash}" == "" ]] && die "Failed to extract VTD hash"
	[[ "${actual_vtd_hash}" != "${VTD_HASH}" ]] && \
		die "VTD hash mismatch, ebuild requested ${VTD_HASH} while package wants ${actual_vtd_hash}"

	mkdir deps || die
	cp "${DISTDIR}/xrt_smi_strx-${VTD_HASH:0:8}.a" deps/xrt_smi_strx.a || die
	cp "${DISTDIR}/xrt_smi_phx-${VTD_HASH:0:8}.a" deps/xrt_smi_phx.a || die

	sed -e "/Unknown Linux package flavor/d" -i "CMake/pkg.cmake" || die

	sed -e "s/set (XRT_UPSTREAM 0)/set (XRT_UPSTREAM 1)/" -i xrt/src/CMake/settings.cmake || die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_DISABLE_FIND_PACKAGE_Git=ON
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}"/usr
		-DSKIP_KMOD=1
		-DUMQ_HELLO_TEST=n

		-DFETCHCONTENT_FULLY_DISCONNECTED=ON
		-DFETCHCONTENT_SOURCE_DIR_VTD_STRX_ARCHIVE="${S}/deps"
		-DFETCHCONTENT_SOURCE_DIR_VTD_PHX_ARCHIVE="${S}/deps"
		-DPython3_EXECUTABLE="${PYTHON}"
		-Wno-dev
	)
	[[ ${PV} != 999999 ]] && mycmakeargs+=( -DCMAKE_DISABLE_FIND_PACKAGE_Git=ON )

	cmake_src_configure
}

src_install() {
	cmake_src_install

	# belongs to dev-util/xrt
	rm -rf "${ED}/bins" || die
}
