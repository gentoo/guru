# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker systemd

DESCRIPTION="Get up and running with local large language models"
HOMEPAGE="https://ollama.com"
SRC_URI="
	amd64? (
		https://github.com/ollama/ollama/releases/download/v${PV}/ollama-linux-amd64.tar.zst
			-> ${PN}-amd64-${PV}.tar.zst
	)
	rocm? (
		https://github.com/ollama/ollama/releases/download/v${PV}/ollama-linux-amd64-rocm.tar.zst
			-> ${PN}-rocm-amd64-${PV}.tar.zst
	)
"
S="${WORKDIR}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="rocm cuda"

RESTRICT="strip"

BDEPEND="
	dev-util/patchelf
"

RDEPEND="
	acct-group/ollama
	acct-group/render
	acct-group/video
	app-arch/bzip2
	app-arch/xz-utils
	app-arch/zstd
	media-libs/vulkan-loader
	sys-libs/zlib-ng
	>=acct-user/ollama-3[cuda?]
	cuda? (
		dev-util/nvidia-cuda-toolkit
	)
	!!sci-ml/ollama
"

QA_PREBUILT="*"

src_prepare() {
	default
	if ! use cuda; then
		rm -rf "${S}"/lib/ollama/{cuda_v12,cuda_v13} || die
	fi
	# no need to strip for rocm, because the folder containing it wouldn't even be fetched and unpacked

	# Shipped upstream libraries come with '$ORIGIN:/build/llama-server-cpu/bin:' set in their RUNPATH
	# scanelf complains about it during install, and we only need $ORIGIN
	# (all libs are in the same folder), so we set it to that
	for so in "${S}"/lib/ollama/*.so; do
		patchelf --set-rpath '$ORIGIN' "${so}" || die
	done
}

src_install(){
	dodir /opt/ollama
	cp -a bin lib "${ED}/opt/ollama/" || die "installing ollama blob failed"

	dosym ../../opt/ollama/bin/ollama                /usr/bin/ollama
	dosym ../../opt/ollama/lib/ollama/llama-server   /usr/bin/llama-server
	dosym ../../opt/ollama/lib/ollama/llama-quantize /usr/bin/llama-quantize

	newinitd "${FILESDIR}/ollama.init" "${PN}"
	newconfd "${FILESDIR}/ollama.confd" "${PN}"

	systemd_dounit "${FILESDIR}/ollama.service"
}
