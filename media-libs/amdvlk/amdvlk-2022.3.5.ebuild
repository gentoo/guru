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
XGL_COMMIT="4118707939c2f4783d28ce2a383184a3794ca477"
PAL_COMMIT="ae55b19b7553bf204b4945de9c11c5b05bc0e167"
LLPC_COMMIT="7857f2e209fc65374f2891be52e3a4a22fbae483"
GPURT_COMMIT="b89f22aadd0a335be632055434a7f8ba152fcb37"
LLVM_PROJECT_COMMIT="5c82ef808fd269c95f5bd166d1846149e3afadc2"
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
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr/lib/llvm/amdvlk"
		-DLLVM_VERSION_SUFFIX="-$(get_libdir)-amdvlk"
		-DCMAKE_BUILD_WITH_INSTALL_RPATH=ON
		-Wno-dev
		)
	cmake_src_configure
}
multilib_src_install(){
	cmake_src_install
	rm -r "${D}"/var/ || die "can't remove incorrect temporary files of amdvlk"
	einfo "Correcting permissions of amdvlk $(get_libdir) libraries"
	fperms -R 775 /usr/lib/llvm/amdvlk/$(get_libdir)
}

multilib_src_install_all() {
	cat > "99${PN}" <<-EOF
		LDPATH="${EPREFIX}/usr/lib/llvm/amdvlk/lib:${EPREFIX}/usr/lib/llvm/amdvlk/lib64"
	EOF
	doenvd "99${PN}"
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
