# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

MY_PV="${PV//./\/}"
MY_LLVM_PV="040a641988f6ed6f4fab250706ca2b620c1de2d8"
CMAKE_BUILD_TYPE="Release"
PYTHON_COMPAT=( python3_{12..14} )
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
		https://github.com/llvm/circt/archive/refs/tags/firtool-${PV}.tar.gz -> ${P}.tar.gz
		https://github.com/llvm/llvm-project/archive/${MY_LLVM_PV}.tar.gz -> llvm-project-${MY_LLVM_PV}.tar.gz
	"
	KEYWORDS="~amd64 ~arm64 ~riscv ~x86"
	S_CIRCT="${WORKDIR}/${PN}-firtool-${PV}"
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
	app-arch/zstd:=
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
		-D CMAKE_SKIP_RPATH=ON
		-D LLVM_ENABLE_PROJECTS=mlir
		-D BUILD_SHARED_LIBS=OFF
		-D LLVM_STATIC_LINK_CXX_STDLIB=ON
		-D LLVM_ENABLE_ASSERTIONS=ON
		# Link zstd deterministically rather than letting cmake autodetect
		# it, so the app-arch/zstd RDEPEND always matches.  See
		# https://bugs.gentoo.org/977877
		-D LLVM_ENABLE_ZSTD=FORCE_ON
		# We do not link Z3 into circt, so the SMT/LEC passes and the z3
		# integration tests cannot work.  Disable z3 discovery entirely so
		# those tests are skipped instead of detected-but-broken.  Without
		# this, a z3 binary on PATH enables the lit 'z3' feature and tests
		# like circt-synth/functional-reduction-z3.mlir run and fail.
		-D Z3_DISABLE=ON
		-D LLVM_BUILD_EXAMPLES=OFF
		-D LLVM_ENABLE_BINDINGS=OFF
		-D LLVM_ENABLE_OCAMLDOC=OFF
		-D LLVM_OPTIMIZED_TABLEGEN=OFF
		-D LLVM_EXTERNAL_PROJECTS=circt
		-D LLVM_EXTERNAL_CIRCT_SOURCE_DIR="${S_CIRCT}"
		-D LLVM_BUILD_TOOLS=ON
	)
	cmake_src_configure
}

src_test() {
	# Only exercise CIRCT's own suites.  check-mlir runs upstream MLIR
	# mlir-runner JIT tests that dlopen the MLIR runtime shared libraries,
	# which our static CMAKE_SKIP_RPATH build does not expose, and which are
	# out of scope for packaging CIRCT.  See https://bugs.gentoo.org/977441
	#
	# The circt-tblgen RTG instruction tests include mlir tablegen headers
	# through circt's llvm submodule path (llvm/mlir/include), which is empty
	# in the release tarball because we build against a separate llvm-project
	# checkout.  Point it at the real tree so those tests find
	# mlir/IR/OpBase.td instead of failing.
	if [[ ! -L ${S_CIRCT}/llvm ]]; then
		rmdir "${S_CIRCT}/llvm" || die
		ln -s "${S_LLVM}" "${S_CIRCT}/llvm" || die
	fi
	pushd "${BUILD_DIR}" || die
	eninja check-circt
	eninja check-circt-integration
	popd || die
}

src_install() {
	mv "${S_LLVM}/llvm/LICENSE.TXT" "${S_LLVM}/llvm/llvm-LICENSE.TXT" || die
	mv "${S_LLVM}/mlir/LICENSE.TXT" "${S_LLVM}/mlir/mlir-LICENSE.TXT" || die
	mv "${S_CIRCT}/LICENSE" "${S_CIRCT}/circt-LICENSE" || die
	einstalldocs

	# Several tools are only built when their optional frontend is present:
	# circt-verilog and circt-verilog-lsp-server need the slang
	# SystemVerilog parser, circt-bmc and circt-lec need Z3.  When those are
	# unavailable the upstream build simply omits the binaries, so install
	# whatever got built instead of aborting.  See
	# https://bugs.gentoo.org/977442
	local tool
	local tools=(
		arcilator circt-as circt-bmc circt-cocotb-driver.py circt-dis
		circt-lec circt-lsp-server circt-opt circt-reduce circt-rtl-sim.py
		circt-synth circt-test circt-translate circt-verilog
		circt-verilog-lsp-server domaintool firld firtool handshake-runner
		hlstool kanagawatool om-linker py-split-input-file.py
	)
	exeinto /usr/bin
	for tool in "${tools[@]}"; do
		if [[ -e "${BUILD_DIR}/bin/${tool}" ]]; then
			doexe "${BUILD_DIR}/bin/${tool}"
		else
			ewarn "Skipping ${tool}, not built (optional frontend unavailable)"
		fi
	done

	[[ -e "${ED}/usr/bin/firtool" ]] || die "firtool was not built"
}
