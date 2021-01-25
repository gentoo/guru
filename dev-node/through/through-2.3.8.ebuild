# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="simplified stream construction"
HOMEPAGE="
	https://github.com/dominictarr/through
	https://www.npmjs.com/package/through
"
SRC_URI="https://registry.npmjs.org/through/-/through-2.3.8.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
