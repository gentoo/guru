# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ROCM_VERSION=6.1
inherit go-module rocm

DESCRIPTION="Get up and running with Llama 3, Mistral, Gemma, and other language models."
HOMEPAGE="https://ollama.com"
SRC_URI="https://github.com/ollama/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
SRC_URI+=" https://github.com/Tapchicoma/ebuild-deps/raw/refs/heads/main/go-deps/${PN}-${PV}-deps.tar.xz"
S="${WORKDIR}/${PN}-${PV}"
LICENSE="MIT"
SLOT="0"

KEYWORDS="~amd64"

IUSE="cuda video_cards_amdgpu
cpu_flags_x86_avx cpu_flags_x86_avx2
cpu_flags_x86_avx512f cpu_flags_x86_avx512vbmi cpu_flags_x86_avx512_vnni cpu_flags_x86_avx512_bf16
"

REQUIRED_USE="
	cpu_flags_x86_avx2? ( cpu_flags_x86_avx )
	cpu_flags_x86_avx512f? ( cpu_flags_x86_avx2 )
	cpu_flags_x86_avx512vbmi? ( cpu_flags_x86_avx512f )
	cpu_flags_x86_avx512_vnni? ( cpu_flags_x86_avx512f )
	cpu_flags_x86_avx512_bf16? ( cpu_flags_x86_avx512f )
"

RDEPEND="
	acct-group/ollama
	acct-user/ollama
"

DEPEND="
	>=dev-lang/go-1.23.4
	>=dev-build/cmake-3.24
	>=sys-devel/gcc-11.4.0
	cuda? ( dev-util/nvidia-cuda-toolkit )
	video_cards_amdgpu? (
		sci-libs/hipBLAS[${ROCM_USEDEP}]
	)
"

pkg_pretend() {
	if use video_cards_amdgpu; then
		ewarn "WARNING: AMD support in this ebuild are experimental"
		einfo "If you run into issues, especially compiling dev-libs/rocm-opencl-runtime"
		einfo "you may try the docker image here https://github.com/ROCm/ROCm-docker"
		einfo "and follow instructions here"
		einfo "https://rocm.docs.amd.com/projects/install-on-linux/en/latest/how-to/docker.html"
	fi
}

src_prepare() {
	default

	if use video_cards_amdgpu; then
		# --hip-version gets appended to the compile flags which isn't a known flag.
		# This causes rocm builds to fail because -Wunused-command-line-argument is turned on.
		# Use nuclear option to fix this.
		# Disable -Werror's from go modules.
		find "${S}" -name ".go" -exec sed -i "s/ -Werror / /g" {} + || die
	fi
}

src_compile() {
	CUSTOM_CPU_FLAGS=""
	use cpu_flags_x86_avx && CUSTOM_CPU_FLAGS+="avx"
	use cpu_flags_x86_avx2 && CUSTOM_CPU_FLAGS+=",avx2"
	use cpu_flags_x86_avx512f && CUSTOM_CPU_FLAGS+=",avx512"
	use cpu_flags_x86_avx512vbmi && CUSTOM_CPU_FLAGS+=",avx512vbmi"
	use cpu_flags_x86_avx512_vnni && CUSTOM_CPU_FLAGS+=",avx512vnni"
	use cpu_flags_x86_avx512_bf16 && CUSTOM_CPU_FLAGS+=",avx512bf16"

	# Build basic ollama executable with cpu features built in
	export CUSTOM_CPU_FLAGS

	if use video_cards_amdgpu; then
		export HIP_ARCHS=$(get_amdgpu_flags)
		export HIP_PATH="/usr"
	else
		export OLLAMA_SKIP_ROCM_GENERATE=1
	fi

	if ! use cuda; then
		export OLLAMA_SKIP_CUDA_GENERATE=1
	fi
	emake dist
}

src_install() {
	dobin dist/linux-${ARCH}/bin/ollama

	if [[ -d "dist/linux-${ARCH}/lib/ollama" ]] ; then
		insinto /usr/lib
		doins -r dist/linux-${ARCH}/lib/ollama
	fi

	doinitd "${FILESDIR}"/ollama
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
