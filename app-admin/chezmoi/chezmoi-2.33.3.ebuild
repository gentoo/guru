# Copyright 2020-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module shell-completion

DESCRIPTION="Manage your dotfiles across multiple machines, securely"
HOMEPAGE="https://www.chezmoi.io/"
SRC_URI="https://github.com/twpayne/chezmoi/archive/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://github.com/rebtoor/portage-deps/raw/master/${P}-deps.tar.xz"

LICENSE="Apache-2.0 BSD BSD-2 MIT MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"

DEPEND="dev-vcs/git"
RDEPEND="${DEPEND}"

src_compile() {
	go build -o ${PN} -v -work -x -ldflags \
		"-X main.version=${PV} -X main.date=$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
		|| die "compile failed"
}

src_test() {
	go test -ldflags \
		"-X github.com/twpayne/chezmoi/v2/pkg/chezmoitest.umaskStr=0o022"
	go test -ldflags \
		"-X github.com/twpayne/chezmoi/v2/pkg/chezmoitest.umaskStr=0o002"
}

src_install() {
	dobin ${PN}

	newbashcomp completions/${PN}-completion.bash ${PN}

	dofishcomp completions/${PN}.fish

	newzshcomp completions/${PN}.zsh _${PN}
}
