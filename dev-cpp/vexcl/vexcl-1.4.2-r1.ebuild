# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

#DOCS_AUTODOC=0
DOCS_BUILDER="sphinx"
DOCS_DEPEND="dev-python/sphinx-bootstrap-theme"
DOCS_DIR="docs"
PYTHON_COMPAT=( python3_{7..9} )

inherit cmake python-any-r1 docs

DESCRIPTION="VexCL - Vector expression template library for OpenCL"
HOMEPAGE="https://github.com/ddemidov/vexcl"
SRC_URI="https://github.com/ddemidov/vexcl/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="amdsi clhpp compute examples jit +opencl test" #cuda clogs
REQUIRED_USE="^^ ( compute jit opencl )" #cuda
RESTRICT="!test? ( test )"

RDEPEND="
	compute? ( dev-libs/boost:= )
	jit? ( virtual/opencl )
	opencl? ( virtual/opencl )
"
DEPEND="${RDEPEND}"

src_prepare() {
	default
	sed -e "s|git_version()|${PV}|g" -i docs/conf.py || die
	cmake_src_prepare
}

src_configure() {
	local backend
#	use  && backend="All"
	use compute && backend="Compute"
#	use cuda && backend="CUDA"
	use jit && backend="JIT"
	use opencl && backend="OpenCL"

	local mycmakeargs=(
		-DVEXCL_BUILD_EXAMPLES=OFF

		-DVEXCL_AMD_SI_WORKAROUND=$(usex amdsi)
		-DVEXCL_BACKEND="${backend}"
		-DVEXCL_BUILD_TESTS=$(usex test)
		-DVEXCL_INSTALL_CL_HPP=$(usex clhpp)
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
