# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
inherit cmake check-reqs python-any-r1

DESCRIPTION="Microsoft DirectX Shader Compiler which is based on LLVM/Clang"
HOMEPAGE="https://github.com/microsoft/DirectXShaderCompiler"
# ToDo: unbundle spirv headers/tools
SPIRV_HEADERS_COMMIT_MAGIC="0bcc624926a25a2a273d07877fd25a6ff5ba1cfb"
SPIRV_TOOLS_COMMIT_MAGIC="71b2aee6c868a673ec82d1385f97593aa2881316"
SRC_URI="https://github.com/microsoft/DirectXShaderCompiler/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
https://github.com/KhronosGroup/SPIRV-Headers/archive/${SPIRV_HEADERS_COMMIT_MAGIC}.tar.gz -> DirectXShaderCompiler-headers-${SPIRV_HEADERS_COMMIT_MAGIC}.tar.gz
https://github.com/KhronosGroup/SPIRV-Tools/archive/${SPIRV_TOOLS_COMMIT_MAGIC}.tar.gz -> DirectXShaderCompiler-tools-${SPIRV_TOOLS_COMMIT_MAGIC}.tar.gz"

LICENSE="Apache-2.0-with-LLVM-exceptions UoI-NCSA BSD public-domain rc"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="${PYTHON_DEPS}"
RDEPEND="
	sys-libs/zlib:0=
	>=dev-libs/libffi-3.4.2-r1:0=
"
BDEPEND="sys-devel/gnuconfig"

CHECKREQS_MEMORY="4G"
CHECKREQS_DISK_BUILD="4G"
CMAKE_EXTRA_CACHE_FILE="${S}/cmake/caches/PredefinedParams.cmake"

src_prepare() {
	rm -d "${S}"/external/SPIRV*
	mv "${WORKDIR}/SPIRV-Headers-${SPIRV_HEADERS_COMMIT_MAGIC}" "${S}/external/SPIRV-Headers" || die "can't move headers"
	mv "${WORKDIR}/SPIRV-Tools-${SPIRV_TOOLS_COMMIT_MAGIC}" "${S}/external/SPIRV-Tools"|| die "can't move tools"
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-Wno-dev
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr/lib/llvm/dxc"
		-DLLVM_BUILD_DOCS=0
		-DLLVM_BUILD_TOOLS=0
		-DSPIRV_BUILD_TESTS=0
		-DLLVM_ENABLE_WERROR=0
		-DSPIRV_WERROR=0
		-DSPIRV_WARN_EVERYTHING=0
		-DBUILD_SHARED_LIBS=OFF
		-DLLVM_VERSION_SUFFIX=dxc
	)
	cmake_src_configure
}
src_install() {
	cmake_src_install
	cat > "99${PN}" <<-EOF
		LDPATH="${EPREFIX}/usr/lib/llvm/dxc/lib"
	EOF
	doenvd "99${PN}"
	dosym -r /usr/lib/llvm/dxc/bin/dxc /usr/bin/dxc
}
