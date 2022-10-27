# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MULTILIB_COMPAT=( abi_x86_{32,64} )
PYTHON_COMPAT=( python3_{8..11} )

inherit check-reqs python-any-r1 cmake-multilib

DESCRIPTION="AMD Open Source Driver for Vulkan"
HOMEPAGE="https://github.com/GPUOpen-Drivers/AMDVLK"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="wayland"
REQUIRED_USE="|| ( abi_x86_32 abi_x86_64 )"

BUNDLED_LLVM_DEPEND="sys-libs/zlib:0=[${MULTILIB_USEDEP}]"
DEPEND="wayland? ( dev-libs/wayland[${MULTILIB_USEDEP}] )
	${BUNDLED_LLVM_DEPEND}
	>=dev-util/vulkan-headers-1.3.224"
BDEPEND="${BUNDLED_LLVM_DEPEND}
	${PYTHON_DEPS}
	dev-util/cmake
	virtual/linux-sources"
RDEPEND=" ${DEPEND}
	x11-libs/libdrm[${MULTILIB_USEDEP}]
	x11-libs/libXrandr[${MULTILIB_USEDEP}]
	x11-libs/libxcb[${MULTILIB_USEDEP}]
	x11-libs/libxshmfence[${MULTILIB_USEDEP}]
	>=media-libs/vulkan-loader-1.3.224[${MULTILIB_USEDEP}]
	dev-util/glslang[${MULTILIB_USEDEP}]
	dev-util/DirectXShaderCompiler"

CHECKREQS_MEMORY="16G"
CHECKREQS_DISK_BUILD="4G"
S="${WORKDIR}"
CMAKE_USE_DIR="${S}/xgl"

###SOURCE CODE PER_VERSION VARIABLES
FETCH_URI="https://github.com/GPUOpen-Drivers"
##For those who wants update ebuild: check https://github.com/GPUOpen-Drivers/AMDVLK/blob/${VERSION}/default.xml , e.g. https://github.com/GPUOpen-Drivers/AMDVLK/blob/v-2022.Q3.5/default.xml
##and place commits in the desired variables
## EXAMPLE: XGL_COMMIT="80e5a4b11ad2058097e77746772ddc9ab2118e07"
## SRC_URI="... ${FETCH_URI}/$PART/archive/$COMMIT.zip -> $PART-$COMMIT.zip ..."
XGL_COMMIT="8a67c76eedb8400fb5d3b1e7b6a3894efdc7a3b9"
PAL_COMMIT="c2af6fc4c14ea61273bcf5576f8a83a12b945dd7"
LLPC_COMMIT="9db0ba4c968bbfe2f3e7e546d17cbfd07dcfdc9e"
GPURT_COMMIT="2874e509b677d78ddb3faae90989dd45e60669b3"
LLVM_PROJECT_COMMIT="d2b67605e4dd5dc50d0afbeb4f20f29cce97b207"
METROHASH_COMMIT="18893fb28601bb9af1154cd1a671a121fff6d8d3"
CWPACK_COMMIT="4f8cf0584442a91d829d269158567d7ed926f026"
# end of variables
SRC_URI="${FETCH_URI}/xgl/archive/${XGL_COMMIT}.tar.gz -> amdvlk-xgl-${XGL_COMMIT}.tar.gz
${FETCH_URI}/pal/archive/${PAL_COMMIT}.tar.gz -> amdvlk-pal-${PAL_COMMIT}.tar.gz
${FETCH_URI}/llpc/archive/${LLPC_COMMIT}.tar.gz -> amdvlk-llpc-${LLPC_COMMIT}.tar.gz
${FETCH_URI}/gpurt/archive/${GPURT_COMMIT}.tar.gz -> amdvlk-gpurt-${GPURT_COMMIT}.tar.gz
${FETCH_URI}/llvm-project/archive/${LLVM_PROJECT_COMMIT}.tar.gz -> amdvlk-llvm-project-${LLVM_PROJECT_COMMIT}.tar.gz
${FETCH_URI}/MetroHash/archive/${METROHASH_COMMIT}.tar.gz -> amdvlk-MetroHash-${METROHASH_COMMIT}.tar.gz
${FETCH_URI}/CWPack/archive/${CWPACK_COMMIT}.tar.gz -> amdvlk-CWPack-${CWPACK_COMMIT}.tar.gz"

PATCHES=(
	"${FILESDIR}/amdvlk-2022.3.5-no-compiler-presets.patch" #875821
	"${FILESDIR}/amdvlk-2022.4.1-proper-libdir.patch"
)

src_prepare() {
	einfo "moving src to proper directories"
	mkdir -p "${S}"
	mkdir -p "${S}/third_party"
	mv xgl-${XGL_COMMIT}/ "${S}/xgl"
	mv pal-${PAL_COMMIT}/ "${S}/pal"
	mv llpc-${LLPC_COMMIT}/ "${S}/llpc"
	mv gpurt-${GPURT_COMMIT}/ "${S}/gpurt"
	mv llvm-project-${LLVM_PROJECT_COMMIT}/ "${S}/llvm-project"
	mv MetroHash-${METROHASH_COMMIT}/ "${S}/third_party/metrohash"
	mv CWPack-${CWPACK_COMMIT}/ "${S}/third_party/cwpack"
	cmake_src_prepare
}

multilib_src_configure() {
	local mycmakeargs=(
		-DBUILD_WAYLAND_SUPPORT=$(usex wayland)
		-DLLVM_VERSION_SUFFIX="-amdvlk"
		-DLLVM_HOST_TRIPLE="${CHOST}"
		-DBUILD_SHARED_LIBS=OFF #LLVM parts don't support shared libs
		-DPython3_EXECUTABLE="${PYTHON}"
		-Wno-dev
		)
	cmake_src_configure
}
multilib_check_headers() {
	einfo "There is no headers"
}

multilib_src_install_all() {
	default
	einfo "Removing unused LLVM parts…"
	rm "${D}"/usr/lib/libLLVM*.a || die "Can't remove unused LLVM static libs"
	rm "${D}"/usr/lib/libLTO* || die "Can't remove unused LLVM lto library"
	rm "${D}"/usr/lib/libRemarks* || die "Can't remove unused LLVM lto library"
	rm -r "${D}"/usr/share/opt-viewer || "Can't remove unused LLVM opt-viewer"
	rm -r "${D}"/usr/include || die "Can't remove unused include folder"
	rm -r "${D}"/usr/lib/cmake || die "Can't remove unused LLVM cmake folder"
	einfo "Removal done! Moving docs…"
	mv "${D}"/usr/share/doc/amdvlk/* "${D}"/usr/share/doc/"amdvlk-${PV}"/ || ewarn "Can't move docs. It is not fatal"
	einfo "Done!"
}

pkg_postinst() {
	ewarn "Make sure the following line is NOT included in the any Xorg configuration section:"
	ewarn "| Driver	  \"modesetting\""
	ewarn "and make sure you use DRI3 mode for Xorg (not revelant for wayland)"
	elog "More information about the configuration can be found here:"
	elog "https://github.com/GPUOpen-Drivers/AMDVLK"
	elog "You can use AMD_VULKAN_ICD variable to switch to the required driver."
	elog "AMD_VULKAN_ICD=RADV application   - for using radv."
	elog "AMD_VULKAN_ICD=AMDVLK application - for using amdvlk."
}
