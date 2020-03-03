# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit git-r3

DESCRIPTION="Blame someone else for your bad code."
HOMEPAGE="https://github.com/jayphelps/git-blame-someone-else"
EGIT_REPO_URI="https://github.com/jayphelps/git-blame-someone-else.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

IUSE=""

RDEPEND="
	dev-vcs/git
"
DEPEND=""

src_install() {
	dobin "${PN}"
	einstalldocs
}
