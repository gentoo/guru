# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/jesseduffield/lazygit"

inherit git-r3 golang-build golang-vcs

DESCRIPTION="Lazygit, a simple terminal UI for git commands"
HOMEPAGE="https://github.com/jesseduffield/lazygit"
EGIT_REPO_URI="https://github.com/jesseduffield/lazygit.git"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="doc"

DEPEND=( sys-libs/glibc )
RDEPEND=(
	${DEPEND}
	dev-vcs/git
)

DOCS=( src/${EGO_PN}/{CONTRIBUTING,README}.md )

src_compile() {
	GOPATH="${S}" go build -v -o bin/lazygit src/${EGO_PN}/main.go || die
}

src_install() {
	dobin bin/lazygit

	use doc && dodoc -r "src/${EGO_PN}/docs/."
	einstalldocs
}
