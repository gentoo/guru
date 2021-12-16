# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MULTILIB_COMPAT=( abi_x86_{32,64} )

inherit cmake-multilib check-reqs

DESCRIPTION="AMD Open Source Driver for Vulkan"
HOMEPAGE="https://github.com/GPUOpen-Drivers/AMDVLK"
LICENSE="MIT"
SLOT="0"
KEYWORDS="" # Package is broken: https://github.com/GPUOpen-Drivers/llpc/issues/1594
IUSE="debug wayland"
REQUIRED_USE="|| ( abi_x86_32 abi_x86_64 )"
###DEPENDS
BUNDLED_LLVM_DEPEND="sys-libs/zlib:0=[${MULTILIB_USEDEP}]"
DEPEND="wayland? ( dev-libs/wayland[${MULTILIB_USEDEP}] )
	${BUNDLED_LLVM_DEPEND}"
BDEPEND="${BUNDLED_LLVM_DEPEND}
	dev-util/cmake"
RDEPEND=" ${DEPEND}
	dev-util/vulkan-headers
	x11-libs/libdrm[${MULTILIB_USEDEP}]
	x11-libs/libXrandr[${MULTILIB_USEDEP}]
	x11-libs/libxcb[${MULTILIB_USEDEP}]
	x11-libs/libxshmfence[${MULTILIB_USEDEP}]
	media-libs/vulkan-loader[${MULTILIB_USEDEP}]"

CHECKREQS_MEMORY="8G"
CHECKREQS_DISK_BUILD="4G"
S="${WORKDIR}"
CMAKE_USE_DIR="${S}/xgl"

###SOURCE CODE VARIABLES
FETCH_URI="https://github.com/GPUOpen-Drivers"
CORRECT_AMDVLK_PV="v-$(ver_rs 1 '.Q')" #Works only for amdvlk source code: transforming version 2019.2.2 to v-2019.Q2.2. Any other commits should be updated manually
##For those who wants update ebuild: check https://github.com/GPUOpen-Drivers/AMDVLK/blob/master/default.xml
##and place commits in the desired variables
## PSEUDOEXAMPLE: XGL_COMMIT="80e5a4b11ad2058097e77746772ddc9ab2118e07"
## SRC_URI="... ${FETCH_URI}/$PART/archive/$COMMIT.zip -> $PART-$COMMIT.zip ..."
XGL_COMMIT="da1a583a51c69c115f9144b68ec2bdf5b6519056"
PAL_COMMIT="61409c1cea19a2ca5ad00461b1e75b3ab46c4389"
LLPC_COMMIT="80b124752f5f689b21d46a3fd459b2df659de187"
SPVGEN_COMMIT="0aa19873514a8272dfdc5cb8861859a52f5de503"
LLVM_PROJECT_COMMIT="63581e1504f3854df7d1ea7aab6af935da1b515d"
METROHASH_COMMIT="3c566dd9cda44ca7fd97659e0b53ac953f9037d2"
CWPACK_COMMIT="39f8940199e60c44d4211cf8165dfd12876316fa"
## SRC_URI
SRC_URI=" ${FETCH_URI}/AMDVLK/archive/${CORRECT_AMDVLK_PV}.tar.gz -> AMDVLK-${CORRECT_AMDVLK_PV}.tar.gz
${FETCH_URI}/xgl/archive/${XGL_COMMIT}.tar.gz -> AMDVLK-${CORRECT_AMDVLK_PV}-xgl-${XGL_COMMIT}.tar.gz
${FETCH_URI}/pal/archive/${PAL_COMMIT}.tar.gz -> AMDVLK-${CORRECT_AMDVLK_PV}-pal-${PAL_COMMIT}.tar.gz
${FETCH_URI}/llpc/archive/${LLPC_COMMIT}.tar.gz -> AMDVLK-${CORRECT_AMDVLK_PV}-llpc-${LLPC_COMMIT}.tar.gz
${FETCH_URI}/spvgen/archive/${SPVGEN_COMMIT}.tar.gz -> AMDVLK-${CORRECT_AMDVLK_PV}-spvgen-${SPVGEN_COMMIT}.tar.gz
${FETCH_URI}/llvm-project/archive/${LLVM_PROJECT_COMMIT}.tar.gz -> AMDVLK-${CORRECT_AMDVLK_PV}-llvm-project-${LLVM_PROJECT_COMMIT}.tar.gz
${FETCH_URI}/MetroHash/archive/${METROHASH_COMMIT}.tar.gz -> AMDVLK-${CORRECT_AMDVLK_PV}-MetroHash-${METROHASH_COMMIT}.tar.gz
${FETCH_URI}/CWPack/archive/${CWPACK_COMMIT}.tar.gz -> AMDVLK-${CORRECT_AMDVLK_PV}-CWPack-${CWPACK_COMMIT}.tar.gz"

###EBUILD FUNCTIONS
src_prepare() {
	##moving src to proper directories
	mkdir -p "${S}"
	mkdir -p "${S}/third_party"
	mv AMDVLK-${CORRECT_AMDVLK_PV}/ "${S}/AMDVLK"
	mv xgl-${XGL_COMMIT}/ "${S}/xgl"
	mv pal-${PAL_COMMIT}/ "${S}/pal"
	mv llpc-${LLPC_COMMIT}/ "${S}/llpc"
	mv spvgen-${SPVGEN_COMMIT}/ "${S}/spvgen"
	mv llvm-project-${LLVM_PROJECT_COMMIT}/ "${S}/llvm-project"
	mv MetroHash-${METROHASH_COMMIT}/ "${S}/third_party/metrohash"
	mv CWPack-${CWPACK_COMMIT}/ "${S}/third_party/cwpack"
	cmake_src_prepare
}

multilib_src_configure() {
	local mycmakeargs=(
			-DBUILD_WAYLAND_SUPPORT=$(usex wayland )
			)
	CMAKE_BUILD_TYPE=$(usex debug "Debug" "Release")
	cmake_src_configure
}

multilib_src_install() {
	cmake_src_install
	if use abi_x86_64 && multilib_is_native_abi; then
		mkdir -p "${D}/usr/lib64/"
		mv "${BUILD_DIR}/icd/amdvlk64.so" "${D}/usr/lib64/"
		insinto /usr/share/vulkan/icd.d
		doins "${S}/AMDVLK/json/Redhat/amd_icd64.json"
	else
		mkdir -p "${D}/usr/lib/"
		mv "${BUILD_DIR}/icd/amdvlk32.so" "${D}/usr/lib/"
		insinto /usr/share/vulkan/icd.d
		doins "${S}/AMDVLK/json/Redhat/amd_icd32.json"
	fi
}

pkg_postinst() {
	elog "More information about the configuration can be found here:"
	elog " https://github.com/GPUOpen-Drivers/AMDVLK"
	ewarn "Make sure the following line is NOT included in the any Xorg configuration section:"
	ewarn "| Driver      \"modesetting\""
	ewarn "and make sure you use DRI3 mode for Xorg (not revelant for wayland)"
	ewarn "Else AMDVLK breaks things"
	ewarn "With some games AMDVLK is still not stable. Use it at you own risk"
	elog "You may want to disable default vulkan mesa provider in package.use \"media-libs/mesa -vulkan\""
	elog "or perform export in /etc/env.d/ variable VK_ICD_FILENAMES=vulkanprovidername:vulkanprovidername2 "
	elog "exampe| VK_ICD_FILENAMES=\"/usr/share/vulkan/icd.d/amd_icd64.json:/usr/share/vulkan/icd.d/amd_icd64.json\""
	elog "For DXVK: use DXVK_FILTER_DEVICE_NAME= variable"
}
