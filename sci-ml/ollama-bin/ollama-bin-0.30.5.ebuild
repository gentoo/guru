# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker systemd

DESCRIPTION="Get up and running with local large language models."
HOMEPAGE="https://ollama.com"
SRC_URI="
	amd64? ( https://github.com/ollama/ollama/releases/download/v${PV}/ollama-linux-amd64.tar.zst )
	rocm?  ( https://github.com/ollama/ollama/releases/download/v${PV}/ollama-linux-amd64-rocm.tar.zst )
"
S="${WORKDIR}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="rocm cuda"

RESTRICT="strip"

RDEPEND="
	acct-group/ollama
	acct-group/render
	acct-group/video
	>=acct-user/ollama-3[cuda?]
	cuda? (
		dev-util/nvidia-cuda-toolkit
	)
"

QA_PREBUILT="*"

src_prepare() {
	default
	if ! use cuda; then
		rm -rf "${S}"/lib/ollama/{cuda_v12,cuda_v13} || die
	fi
	# no need to strip for rocm, because the folder containing it wouldn't even be fetched and unpacked
}

src_install(){
	dodir /opt/ollama
	cp -a bin lib "${ED}/opt/ollama/" || die "installing ollama blob failed"

	dosym ../../opt/ollama/bin/ollama                /usr/bin/ollama
	dosym ../../opt/ollama/lib/ollama/llama-server   /usr/bin/llama-server
	dosym ../../opt/ollama/lib/ollama/llama-quantize /usr/bin/llama-quantize

	systemd_dounit "${FILESDIR}/ollama.service"
}
