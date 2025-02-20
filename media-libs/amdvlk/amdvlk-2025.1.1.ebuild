# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MULTILIB_COMPAT=( abi_x86_{32,64} )
PYTHON_COMPAT=( python3_{11..13} )

inherit check-reqs python-any-r1 cmake-multilib

DESCRIPTION="AMD Open Source Driver for Vulkan"
HOMEPAGE="https://github.com/GPUOpen-Drivers/AMDVLK"

### SOURCE CODE PER_VERSION VARIABLES
FETCH_URI="https://github.com/GPUOpen-Drivers"
## For those who wants update ebuild: check https://github.com/GPUOpen-Drivers/AMDVLK/blob/${VERSION}/default.xml
## e.g. https://github.com/GPUOpen-Drivers/AMDVLK/blob/v-2022.Q3.5/default.xml
## and place commits in the desired variables
## EXAMPLE: XGL_COMMIT="80e5a4b11ad2058097e77746772ddc9ab2118e07"
## SRC_URI="... ${FETCH_URI}/$PART/archive/$COMMIT.zip -> $PART-$COMMIT.zip ..."
XGL_COMMIT="f1409335d242ba9007b108f10a8c5bdb7372e275"
PAL_COMMIT="29f5d822b6d450dc669a47d2fa709c0b76dfff33"
LLPC_COMMIT="6222f1ff6ba7f00b085003c1a05fdbdc31356235"
GPURT_COMMIT="c3a4d170f0bacc81df90716887b6546ab41ff5f2"
LLVM_PROJECT_COMMIT="4acbac52642be426f92d3f86ad44089e5f65ea5d"
METROHASH_COMMIT="18893fb28601bb9af1154cd1a671a121fff6d8d3"
CWPACK_COMMIT="4f8cf0584442a91d829d269158567d7ed926f026"
# Submodule of LLPC, also updates often. Grab commit version from
# https://github.com/GPUOpen-Drivers/llpc/tree/${LLPC_COMMIT}/imported
LLVM_DIALECTS_COMMIT="50e4ca3a5c365b0bde36b122cc34256406723049"
### end of variables
SRC_URI="${FETCH_URI}/xgl/archive/${XGL_COMMIT}.tar.gz -> amdvlk-xgl-${XGL_COMMIT}.tar.gz
${FETCH_URI}/pal/archive/${PAL_COMMIT}.tar.gz -> amdvlk-pal-${PAL_COMMIT}.tar.gz
${FETCH_URI}/llpc/archive/${LLPC_COMMIT}.tar.gz -> amdvlk-llpc-${LLPC_COMMIT}.tar.gz
${FETCH_URI}/gpurt/archive/${GPURT_COMMIT}.tar.gz -> amdvlk-gpurt-${GPURT_COMMIT}.tar.gz
${FETCH_URI}/llvm-project/archive/${LLVM_PROJECT_COMMIT}.tar.gz -> amdvlk-llvm-project-${LLVM_PROJECT_COMMIT}.tar.gz
${FETCH_URI}/MetroHash/archive/${METROHASH_COMMIT}.tar.gz -> amdvlk-MetroHash-${METROHASH_COMMIT}.tar.gz
${FETCH_URI}/CWPack/archive/${CWPACK_COMMIT}.tar.gz -> amdvlk-CWPack-${CWPACK_COMMIT}.tar.gz
${FETCH_URI}/llvm-dialects/archive/${LLVM_DIALECTS_COMMIT}.tar.gz -> amdvlk-LLVM-dialects-${LLVM_DIALECTS_COMMIT}.tar.gz"

S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="wayland +raytracing"
REQUIRED_USE="|| ( abi_x86_32 abi_x86_64 )"

BUNDLED_LLVM_DEPEND="sys-libs/zlib:0=[${MULTILIB_USEDEP}]"
DEPEND="wayland? ( dev-libs/wayland[${MULTILIB_USEDEP}] )
	${BUNDLED_LLVM_DEPEND}
	app-arch/zstd:=[${MULTILIB_USEDEP}]
	>=dev-util/vulkan-headers-1.3.296
	raytracing? ( dev-util/DirectXShaderCompiler )
	dev-util/glslang[${MULTILIB_USEDEP}]"
BDEPEND="${BUNDLED_LLVM_DEPEND}
	${PYTHON_DEPS}
	$(python_gen_any_dep '
		dev-python/ruamel-yaml[${PYTHON_USEDEP}]
		dev-python/jinja2[${PYTHON_USEDEP}]
	')
	virtual/linux-sources"
RDEPEND=" ${DEPEND}
	x11-libs/libdrm[${MULTILIB_USEDEP}]
	x11-libs/libXrandr[${MULTILIB_USEDEP}]
	x11-libs/libxcb[${MULTILIB_USEDEP}]
	x11-libs/libxshmfence[${MULTILIB_USEDEP}]
	>=media-libs/vulkan-loader-1.3.296[${MULTILIB_USEDEP}]
	dev-util/glslang[${MULTILIB_USEDEP}]
	dev-libs/openssl[${MULTILIB_USEDEP}]" #890449

CHECKREQS_MEMORY="7G"
CHECKREQS_DISK_BUILD="4G"
CMAKE_USE_DIR="${S}/xgl"
CMAKE_MAKEFILE_GENERATOR=ninja

PATCHES=(
	"${FILESDIR}/amdvlk-2022.3.5-no-compiler-presets.patch" #875821
	"${FILESDIR}/amdvlk-2022.4.1-proper-libdir.patch"
	"${FILESDIR}/amdvlk-2024.4.1-license-path.patch" #878803
	#"${FILESDIR}/amdvlk-2022.4.2-reduced-llvm-installations.patch"
	#"${FILESDIR}/amdvlk-2022.4.2-reduced-llvm-installations-part2.patch"
	"${FILESDIR}/amdvlk-2024.3.1-disable-Werror.patch"
)

python_check_deps() {
	python_has_version "dev-python/ruamel-yaml[${PYTHON_USEDEP}]" &&
	python_has_version "dev-python/jinja2[${PYTHON_USEDEP}]"
}

pkg_pretend(){
	ewarn "It's generally recomended to have at least 16GB memory to build"
	ewarn "However, experiments shows that if you'll use MAKEOPTS=\"-j1\" you can build it with 4GB RAM"
	ewarn "or you can use MAKEOPTS=\"-j3\" with 7.5GB system memory"
	ewarn "See https://wiki.gentoo.org/wiki/AMDVLK#Additional_system_requirements_to_build"
	ewarn "Use CHECKREQS_DONOTHING=1 if you need to bypass memory checking"

	check-reqs_pkg_pretend
}

src_prepare() {
	use elibc_musl && PATCHES+=( "${FILESDIR}/amdvlk-2025.1.1-support-musl.patch" )

	einfo "moving src to proper directories"
	mkdir third_party || die
	mv xgl-${XGL_COMMIT}/ xgl || die
	mv pal-${PAL_COMMIT}/ pal || die
	mv llpc-${LLPC_COMMIT}/ llpc || die
	mv gpurt-${GPURT_COMMIT}/ gpurt || die
	mv llvm-project-${LLVM_PROJECT_COMMIT}/ llvm-project || die
	rm -d llpc/imported/llvm-dialects/ || die
	mv llvm-dialects-${LLVM_DIALECTS_COMMIT}/ llpc/imported/llvm-dialects/ || die
	mv MetroHash-${METROHASH_COMMIT}/ third_party/metrohash || die
	mv CWPack-${CWPACK_COMMIT}/ third_party/cwpack || die
	cmake_src_prepare

	# disable forced optimization
	sed -i '/-O3/d' xgl/cmake/XglCompilerOptions.cmake || die
}

multilib_src_configure() {
	local mycmakeargs=(
		-DVKI_BUILD_WAYLAND=$(usex wayland)
		-DVKI_RAY_TRACING=$(usex raytracing)
		-DLLVM_HOST_TRIPLE="${CHOST}"
		-DLLVM_ENABLE_WERROR=OFF
		-DENABLE_WERROR=OFF
		-DVAM_ENABLE_WERROR=OFF
		-DVKI_ANALYSIS_WARNINGS_AS_ERRORS=OFF
		-DMETROHASH_ENABLE_WERROR=OFF
		-DBUILD_SHARED_LIBS=OFF #LLVM parts don't support shared libs
		-DPython3_EXECUTABLE="${PYTHON}"
		-DPACKAGE_VERSION="${PV}"
		-DPACKAGE_NAME="${PN}"
		-DLLVM_INSTALL_TOOLCHAIN_ONLY=ON #Disable installation of various LLVM parts which we had to clean up.
		-Wno-dev
		)
	cmake_src_configure
}

multilib_check_headers() {
	einfo "Checking headers skipped: there is no headers"
}

multilib_src_install_all() {
	default
	einfo "Removing unused LLVM parts…"
	rm "${ED}"/usr/lib/libLTO* || die "Can't remove unused LLVM lto library"
	rm "${ED}"/usr/lib/libRemarks* || die "Can't remove unused LLVM libRemarks library"
	rm -r "${ED}"/usr/lib/cmake || die "Can't remove unused LLVM cmake folder"
	einfo "Removal done"
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
