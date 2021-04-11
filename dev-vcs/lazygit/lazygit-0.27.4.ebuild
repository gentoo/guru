# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/jesseduffield/lazygit"

inherit golang-build golang-vcs-snapshot

DESCRIPTION="Lazygit, a simple terminal UI for git commands"
HOMEPAGE="https://github.com/jesseduffield/lazygit"
SRC_URI="https://github.com/jesseduffield/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
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
