# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ROCM_VERSION=6.1
inherit cuda rocm
inherit go-module

DESCRIPTION="Get up and running with Llama 3, Mistral, Gemma, and other language models."
HOMEPAGE="https://ollama.com"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ollama/ollama.git"
else
	SRC_URI="
		https://github.com/ollama/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz
		https://github.com/Tapchicoma/ebuild-deps/raw/refs/heads/main/go-deps/${PN}-${PV}-deps.tar.xz
	"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

X86_CPU_FLAGS=(
	avx
	avx2
	avx512f
	avx512vbmi
	avx512_vnni
	avx512_bf16
)
CPU_FLAGS=( "${X86_CPU_FLAGS[@]/#/cpu_flags_x86_}" )
IUSE="${CPU_FLAGS[*]} cuda rocm"

REQUIRED_USE="
	cpu_flags_x86_avx2? ( cpu_flags_x86_avx )
	cpu_flags_x86_avx512f? ( cpu_flags_x86_avx2 )
	cpu_flags_x86_avx512vbmi? ( cpu_flags_x86_avx512f )
	cpu_flags_x86_avx512_vnni? ( cpu_flags_x86_avx512f )
	cpu_flags_x86_avx512_bf16? ( cpu_flags_x86_avx512f )
"

DEPEND="
	>=dev-lang/go-1.23.4
	cuda? (
		dev-util/nvidia-cuda-toolkit:=
	)
	rocm? (
		>=sci-libs/hipBLAS-${ROCM_VERSION}:=[${ROCM_USEDEP}]
	)
"

RDEPEND="
	acct-group/${PN}
	acct-user/${PN}
"

PATCHES=(
	"${FILESDIR}/${PN}-0.5.7-include-cstdint.patch"
)

pkg_pretend() {
	if use rocm; then
		ewarn "WARNING: AMD support in this ebuild are experimental"
		einfo "If you run into issues, especially compiling dev-libs/rocm-opencl-runtime"
		einfo "you may try the docker image here https://github.com/ROCm/ROCm-docker"
		einfo "and follow instructions here"
		einfo "https://rocm.docs.amd.com/projects/install-on-linux/en/latest/how-to/docker.html"
	fi
}

src_prepare() {
	default

	sed \
		-e "s/(CFLAGS)/(NVCCFLAGS)/g" \
		-e "s/(CXXFLAGS)/(NVCCFLAGS)/g" \
		-i make/cuda.make || die

	if use rocm; then
		# --hip-version gets appended to the compile flags which isn't a known flag.
		# This causes rocm builds to fail because -Wunused-command-line-argument is turned on.
		# Use nuclear option to fix this.
		# Disable -Werror's from go modules.
		find "${S}" -name ".go" -exec sed -i "s/ -Werror / /g" {} + || die
	fi
}

src_configure() {
	local CUSTOM_CPU_FLAGS=()
	use cpu_flags_x86_avx && CUSTOM_CPU_FLAGS+=( "avx" )
	use cpu_flags_x86_avx2 && CUSTOM_CPU_FLAGS+=( "avx2" )
	use cpu_flags_x86_avx512f && CUSTOM_CPU_FLAGS+=( "avx512" )
	use cpu_flags_x86_avx512vbmi && CUSTOM_CPU_FLAGS+=( "avx512vbmi" )
	use cpu_flags_x86_avx512_vnni && CUSTOM_CPU_FLAGS+=( "avx512vnni" )
	use cpu_flags_x86_avx512_bf16 && CUSTOM_CPU_FLAGS+=( "avx512bf16" )

	# Build basic ollama executable with cpu features built in
	emakeargs=(
		# CCACHE=""
		"CUSTOM_CPU_FLAGS=$( IFS=','; echo "${CUSTOM_CPU_FLAGS[*]}")"
	)

	if use cuda; then
		export NVCC_CCBIN
		NVCC_CCBIN="$(cuda_gccdir)"

		if [[ -n ${CUDAARCHS} ]]; then
			emakeargs+=(
				CUDA_ARCHITECTURES="${CUDAARCHS}"
			)
		fi

		if has_version "=dev-util/nvidia-cuda-toolkit-12*"; then
			emakeargs+=(
				CUDA_12_COMPILER="${CUDA_PATH:=${EPREFIX}/opt/cuda}/bin/nvcc"
				CUDA_12_PATH="${CUDA_PATH:=${EPREFIX}/opt/cuda}"
			)
		fi

		if has_version "=dev-util/nvidia-cuda-toolkit-11*"; then
			emakeargs+=(
				CUDA_11_COMPILER="${CUDA_PATH:=${EPREFIX}/opt/cuda}/bin/nvcc"
				CUDA_11_PATH="${CUDA_PATH:=${EPREFIX}/opt/cuda}"
			)
		fi

		cuda_add_sandbox -w
	else
		emakeargs+=( OLLAMA_SKIP_CUDA_GENERATE="1" )
	fi

	if use rocm; then
		emakeargs+=(
			HIP_ARCHS="$(get_amdgpu_flags)"
			HIP_PATH="${EPREFIX}/usr"
		)

		check_amdgpu
	else
		emakeargs+=( OLLAMA_SKIP_ROCM_GENERATE="1" )
	fi

	emake "${emakeargs[@]}" help-runners
	export emakeargs
}

src_compile() {
	emake "${emakeargs[@]}" dist
}

src_install() {
	dobin "dist/linux-${ARCH}/bin/ollama"

	if [[ -d "dist/linux-${ARCH}/lib/ollama" ]] ; then
		insinto /usr/lib
		doins -r "dist/linux-${ARCH}/lib/ollama"
	fi

	if use rocm; then
		fperms +x /usr/lib/ollama/runners/rocm/ollama_llama_server
	fi

	doinitd "${FILESDIR}"/ollama.init
}

pkg_preinst() {
	keepdir /var/log/ollama
	fowners ollama:ollama /var/log/ollama
}

pkg_postinst() {
	einfo "Quick guide:"
	einfo "ollama serve"
	einfo "ollama run llama3:70b"
	einfo "See available models at https://ollama.com/library"
}
