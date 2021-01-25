# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="A javascript text diff implementation."
HOMEPAGE="
	https://github.com/kpdecker/jsdiff
	https://www.npmjs.com/package/diff
"
SRC_URI="https://registry.npmjs.org/diff/-/diff-5.0.0.tgz"
LICENSE="BSD"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
