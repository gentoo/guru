# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module bash-completion-r1

DESCRIPTION="Manage your dotfiles across multiple machines, securely"
HOMEPAGE="https://chezmoi.io/"
SRC_URI="https://github.com/twpayne/chezmoi/archive/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://github.com/ran-dall/portage-deps/raw/master/${P}-deps.tar.xz"

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
	go test -race -ldflags \
		"-X github.com/twpayne/chezmoi/internal/chezmoitest.umaskStr=0o022" \
		|| die "tests failed"
}

src_install() {
	dobin ${PN}

	newbashcomp completions/${PN}-completion.bash ${PN}

	insinto /usr/share/fish/vendor_completions.d
	doins completions/${PN}.fish

	insinto /usr/share/zsh/site-functions
	newins completions/${PN}.zsh _${PN}
}
