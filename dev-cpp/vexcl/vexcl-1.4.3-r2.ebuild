# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOCS_BUILDER="sphinx"
DOCS_DEPEND="
	dev-python/breathe
	dev-python/sphinx-bootstrap-theme
"
DOCS_DIR="docs"
PYTHON_COMPAT=( python3_{10..11} )

inherit cmake python-any-r1 docs

DESCRIPTION="VexCL - Vector expression template library for OpenCL"
HOMEPAGE="https://github.com/ddemidov/vexcl"
SRC_URI="https://github.com/ddemidov/vexcl/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE_BACKEND="
	backend_compute
	backend_jit
	+backend_opencl
"
#	backend_cuda
IUSE="${IUSE_BACKEND} amdsi examples test" #clogs

RDEPEND="
	dev-libs/boost:=
	dev-cpp/clhpp
	backend_jit? ( virtual/opencl )
	backend_opencl? ( virtual/opencl )
"
DEPEND="${RDEPEND}"

REQUIRED_USE="^^ ( ${IUSE_BACKEND//+/} )"
RESTRICT="!test? ( test )"

src_prepare() {
	sed -e "s|git_version()|\'${PV}\'|g" -i docs/conf.py || die
	cmake_src_prepare
}

src_configure() {
	local backend
#	use  && backend="All"
	use backend_compute && backend="Compute"
#	use backend_cuda && backend="CUDA"
	use backend_jit && backend="JIT"
	use backend_opencl && backend="OpenCL"

	local mycmakeargs=(
		-DBoost_USE_STATIC_LIBS=OFF
		-DVEXCL_INSTALL_CL_HPP=OFF

		-DVEXCL_AMD_SI_WORKAROUND=$(usex amdsi)
		-DVEXCL_BACKEND="${backend}"
		-DVEXCL_BUILD_EXAMPLES=$(usex examples)
		-DVEXCL_BUILD_TESTS=$(usex test)
	)
#		-DVEXCL_CLOGS=$(usex clogs)

	cmake_src_configure
}

src_compile() {
	cmake_src_compile
	docs_compile
}

src_install() {
	cmake_src_install
	if use doc; then
		dodoc -r docs/html
		docompress -x "/usr/share/doc/${P}/html"
	fi
	if use examples; then
		dodoc -r examples
		docompress -x "/usr/share/doc/${P}/examples"
	fi
}
