# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo go-module shell-completion

DESCRIPTION="Feature-rich terminal pager"
HOMEPAGE="https://github.com/noborus/ov"
SRC_URI="https://github.com/noborus/${PN}/releases/download/v${PV}/${P}.tar.gz"

LICENSE="MIT Apache-2.0 BSD-2 BSD MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}"

src_compile() {
	ego build -v -x -o ${PN} -ldflags="-X main.Version=${PV}"
	edo ./ov --config ov.yaml --completion fish > ov.fish
	edo ./ov --config ov.yaml --completion bash > ov.bash
	edo ./ov --config ov.yaml --completion zsh > ov.zsh
}

src_install() {
	dodoc README.md ov{,-less}.yaml
	dobin ov
	newbashcomp "${PN}.bash" "${PN}"
	dofishcomp "${PN}.fish"
	newzshcomp "${PN}.zsh" "_${PN}"
}

src_test() {
	ego test $(ego list ./... | grep -v /vendor/)
}
