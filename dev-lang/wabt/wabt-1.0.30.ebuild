# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )

inherit cmake python-any-r1

DESCRIPTION="The WebAssembly Binary Toolkit"
HOMEPAGE="https://github.com/WebAssembly/wabt"
SRC_URI="https://github.com/WebAssembly/wabt/releases/download/${PV}/${P}.tar.xz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RESTRICT="!test? ( test )"

DEPEND="test? ( dev-cpp/gtest )"
BDEPEND="
	${PYTHON_DEPS}
	$(python_gen_any_dep 'dev-python/ply[${PYTHON_USEDEP}]')
"

PATCHES=(
	# Disable tests depending on third_party/wasm-c-api/example/*.wasm
	"${FILESDIR}/wabt-1.0.30-wasm-blob-tests.patch"
)

python_check_deps() {
	python_has_version "dev-python/ply[${PYTHON_USEDEP}]"
}

src_prepare() {
	cmake_src_prepare

	# Submodules kept: third_party/testsuite third_party/wasm-c-api
	rm -r third_party/gtest third_party/ply third_party/uvwasi || die

	rm third_party/wasm-c-api/example/*.wasm fuzz-in/wasm/stuff.wasm wasm2c/examples/fac/fac.wasm || die

	sed -i 's;default_compiler =.*;default_compiler = os.getenv("CC", "cc");' test/run-spec-wasm2c.py || die
}

src_configure() {
	local mycmakeargs=(
		-DUSE_SYSTEM_GTEST=ON
		-DBUILD_LIBWASM=ON
		-DWITH_WASI=OFF # Need to unbundle third_party/uvwasi
		-DBUILD_TESTS=$(usex test)
	)

	cmake_src_configure
}

src_test() {
	cmake_build check
}
