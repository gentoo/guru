# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="split a Text Stream into a Line Stream"
HOMEPAGE="
	https://github.com/dominictarr/split
	https://www.npmjs.com/package/split
"
SRC_URI="https://registry.npmjs.org/split/-/split-1.0.1.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/through
"
