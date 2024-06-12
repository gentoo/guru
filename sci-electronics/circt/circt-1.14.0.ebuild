# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

MY_PV="${PV//./\/}"
MY_LLVM_PV="fe0f72d5c55a9b95c5564089e946e8f08112e995"
CMAKE_BUILD_TYPE="Release"
PYTHON_COMPAT=( python3_{11..12} )
inherit cmake python-r1

DESCRIPTION="The fast free Verilog/SystemVerilog simulator"
HOMEPAGE="
	https://circt.llvm.org
	https://github.com/llvm/circt
"

if [[ "${PV}" == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/llvm/${PN}.git"
	S_CIRCT="${EGIT_CHECKOUT_DIR}"
	S_LLVM="${S_CIRCT}/llvm"
	S="${S_LLVM}/llvm"
else
	SRC_URI="
		https://github.com/llvm/circt/archive/refs/tags/sifive/${MY_PV}.tar.gz -> ${P}.tar.gz
		https://github.com/llvm/llvm-project/archive/${MY_LLVM_PV}.tar.gz -> llvm-project-${MY_LLVM_PV}.tar.gz
	"
	KEYWORDS="~amd64 ~arm64 ~riscv ~x86"
	S_CIRCT="${WORKDIR}/${PN}-sifive-$(ver_cut 1)-$(ver_cut 2)-$(ver_cut 3)"
	S_LLVM="${WORKDIR}/llvm-project-${MY_LLVM_PV}"
	S="${S_LLVM}/llvm"
fi

LICENSE="Apache-2.0-with-LLVM-exceptions UoI-NCSA BSD public-domain rc"
SLOT="0"
IUSE="test"
REQUIRED_USE=" ${PYTHON_REQUIRED_USE} "

RESTRICT="!test? ( test )"

RDEPEND="
	${PYTHON_DEPS}
	test? (
		dev-python/psutil[${PYTHON_USEDEP}]
		sci-electronics/verilator
	)
	sys-libs/ncurses:0=
"

DEPEND="
	${RDEPEND}
"

BDEPEND="
	virtual/pkgconfig
"

DOCS=(
	"${S_LLVM}/llvm/llvm-LICENSE.TXT"
	"${S_LLVM}/mlir/mlir-LICENSE.TXT"
	"${S_CIRCT}/circt-LICENSE"
)

src_configure() {
	python_setup

	local mycmakeargs=(
		-D Python3_EXECUTABLE="${PYTHON}"
		-D CMAKE_INSTALL_PREFIX=/usr
		-D LLVM_BINUTILS_INCDIR=/usr/include
		-D LLVM_ENABLE_PROJECTS=mlir
		-D BUILD_SHARED_LIBS=OFF
		-D LLVM_STATIC_LINK_CXX_STDLIB=ON
		-D LLVM_ENABLE_ASSERTIONS=ON
		-D LLVM_BUILD_EXAMPLES=OFF
		-D LLVM_ENABLE_BINDINGS=OFF
		-D LLVM_ENABLE_OCAMLDOC=OFF
		-D LLVM_OPTIMIZED_TABLEGEN=ON
		-D LLVM_EXTERNAL_PROJECTS=circt
		-D LLVM_EXTERNAL_CIRCT_SOURCE_DIR="${S_CIRCT}"
		-D LLVM_BUILD_TOOLS=ON
	)
	cmake_src_configure
}

src_test() {
	pushd "${BUILD_DIR}" || die
	eninja check-mlir
	eninja check-circt
	eninja check-circt-integration
	popd || die
}

src_install() {
	mv "${S_LLVM}/llvm/LICENSE.TXT" "${S_LLVM}/llvm/llvm-LICENSE.TXT" || die
	mv "${S_LLVM}/mlir/LICENSE.TXT" "${S_LLVM}/mlir/mlir-LICENSE.TXT" || die
	mv "${S_CIRCT}/LICENSE" "${S_CIRCT}/circt-LICENSE" || die
	einstalldocs
	exeinto /usr/bin
	doexe "${BUILD_DIR}"/bin/circt-capi-ir-test
	doexe "${BUILD_DIR}"/bin/circt-lsp-server
	doexe "${BUILD_DIR}"/bin/circt-opt
	doexe "${BUILD_DIR}"/bin/circt-reduce
	doexe "${BUILD_DIR}"/bin/circt-rtl-sim.py
	doexe "${BUILD_DIR}"/bin/circt-translate
	doexe "${BUILD_DIR}"/bin/esi_cosim.py
	doexe "${BUILD_DIR}"/bin/esi-cosim-runner.py
	doexe "${BUILD_DIR}"/bin/esi-tester
	doexe "${BUILD_DIR}"/bin/firtool
	doexe "${BUILD_DIR}"/bin/handshake-runner
	doexe "${BUILD_DIR}"/bin/llhd-sim
	doexe "${BUILD_DIR}"/bin/py-split-input-file.py
	# llhd-sim not static linked
	dolib.so "${BUILD_DIR}"/lib/libcirct-llhd-signals-runtime-wrappers.so
}
