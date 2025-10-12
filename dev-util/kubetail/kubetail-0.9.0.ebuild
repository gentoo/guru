# Copyright 2021-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit shell-completion

DESCRIPTION="Real-time logging dashboard for Kubernetes"

HOMEPAGE="https://github.com/kubetail-org/kubetail"

SRC_URI="https://github.com/kubetail-org/kubetail/archive/refs/tags/cli/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/kubetail-cli-v${PV}"

LICENSE="Apache-2.0"

SLOT="0"

KEYWORDS="~amd64 ~arm64"

BDEPEND="
	>=dev-lang/go-1.24.7
	>=net-libs/nodejs-22.13.1
	>=sys-apps/pnpm-bin-10.2.0
"

RDEPEND="sys-cluster/kubectl"

QA_PREBUILT="usr/bin/kubetail"

src_compile() {
	emake

	./bin/kubetail completion bash > "kubetail.bash" || die
	./bin/kubetail completion zsh > "kubetail.zsh" || die
	./bin/kubetail completion fish > "kubetail.fish" || die
}

src_install() {
	dobin bin/kubetail || die

	newbashcomp "kubetail.bash" kubetail
	newzshcomp "kubetail.zsh" "_kubetail"
	dofishcomp "kubetail.fish"
}
