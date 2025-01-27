# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake llvm

LLVM_MAX_SLOT=16

EGIT_REPO_URI="https://github.com/ggerganov/llama.cpp.git"
inherit git-r3

if [[ "${PV}" != "9999" ]]; then
	KEYWORDS="~amd64 ~arm64"
	EGIT_COMMIT="b${PV#0_pre}"
fi

DESCRIPTION="Port of Facebook's LLaMA model in C/C++"
HOMEPAGE="https://github.com/ggerganov/llama.cpp"

LICENSE="MIT"
SLOT="0"
IUSE="cublas tests tools"
CPU_FLAGS_X86=( avx avx2 f16c )

DEPEND="
	cublas? ( dev-util/nvidia-cuda-toolkit )"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DLLAMA_CUBLAS="$(usex cublas)"
		-DLLAMA_BUILD_TESTS="$(usex tests)"
		-DLLAMA_BUILD_SERVER=OFF
		-DCMAKE_SKIP_BUILD_RPATH=ON
		-DBUILD_NUMBER="1"
	)
	if use cublas ; then
		addpredict /dev/nvidiactl
	fi
	cmake_src_configure
}
