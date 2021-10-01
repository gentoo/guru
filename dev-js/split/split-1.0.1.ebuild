# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="split a Text Stream into a Line Stream"
HOMEPAGE="
	https://github.com/dominictarr/split
	https://www.npmjs.com/package/split
"
LICENSE="MIT"
KEYWORDS="~amd64"
IUSE="examples"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/through
"

src_install() {
	use examples && dodoc -r examples
	rm -rf examples || die
	node_src_install
}
