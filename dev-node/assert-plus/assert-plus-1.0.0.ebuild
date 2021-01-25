# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="Extra assertions on top of node's assert module"
HOMEPAGE="
	https://github.com/mcavage/node-assert-plus
	https://www.npmjs.com/package/assert-plus
"
SRC_URI="https://registry.npmjs.org/assert-plus/-/assert-plus-1.0.0.tgz -> ${P}.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
