# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Simple terminal UI for git commands"
HOMEPAGE="https://github.com/jesseduffield/lazygit"
if [[ "${PV}" == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/jesseduffield/${PN}.git"
else
	KEYWORDS="~amd64"
	SRC_URI="https://github.com/jesseduffield/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="Apache-2.0 BSD ISC MIT Unlicense"
SLOT="0"
RDEPEND="dev-vcs/git"

DOCS=( {CODE-OF-CONDUCT,CONTRIBUTING,README}.md docs )

src_unpack() {
	if [[ "$PV" == *9999* ]];then
		git-r3_src_unpack
	else
		default
	fi
}

src_compile() {
	ego build -o "bin/${PN}" \
		-ldflags "-X main.version=${PV}"
}

src_test() {
	ego test ./... -short
}

src_install() {
	dobin "bin/${PN}"
	einstalldocs
}
