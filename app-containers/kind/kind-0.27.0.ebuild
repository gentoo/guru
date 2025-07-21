# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo go-module shell-completion

DESCRIPTION="Kind is a tool for running local Kubernetes clusters using Docker"
HOMEPAGE="https://kind.sigs.k8s.io/"
SRC_URI="https://github.com/kubernetes-sigs/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://github.com/ingenarel/guru-depfiles/releases/download/${P}-deps.tar.xz/${P}-deps.tar.xz"

LICENSE="Apache-2.0 BSD BSD-2 MPL-2.0 MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=app-containers/docker-cli-23.0.0"

src_compile() {
	ego build -v -x -o ${PN}
	edo ./${PN} completion fish > kind.fish
	edo ./${PN} completion bash > kind.bash
	edo ./${PN} completion zsh > kind.zsh
}

src_install() {
	dobin ${PN}
	newbashcomp "${PN}.bash" "${PN}"
	dofishcomp "${PN}.fish"
	newzshcomp "${PN}.zsh" "_${PN}"
}
