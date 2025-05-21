# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module git-r3

DESCRIPTION="Simple terminal UI for git commands"
HOMEPAGE="https://github.com/jesseduffield/lazygit"
EGIT_REPO_URI="https://github.com/jesseduffield/lazygit.git"

LICENSE="Apache-2.0 BSD ISC MIT Unlicense"
SLOT="0"

RDEPEND="dev-vcs/git"

DOCS=( {CODE-OF-CONDUCT,CONTRIBUTING,README}.md docs )

src_unpack() {
	git-r3_src_unpack
}

src_compile() {
	ego build -o bin/lazygit -ldflags "-X main.version=${PV}"
}

src_test() {
	ego test ./... -short
}

src_install() {
	dobin bin/lazygit
	einstalldocs
}
