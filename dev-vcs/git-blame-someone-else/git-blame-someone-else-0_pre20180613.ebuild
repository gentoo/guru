# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

COMMIT="8d854c2d78cb98afdb9f5a73240e06393260b327"

SRC_URI="https://github.com/jayphelps/git-blame-someone-else/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
DESCRIPTION="Blame someone else for your bad code."
HOMEPAGE="https://github.com/jayphelps/git-blame-someone-else"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"


RDEPEND="
	dev-vcs/git
"

S="${WORKDIR}/${PN}-${COMMIT}"

src_install() {
	dobin "${PN}"
	einstalldocs
}
