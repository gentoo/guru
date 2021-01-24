# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Fast deep equal"
HOMEPAGE="
	https://github.com/epoberezkin/fast-deep-equal
	https://www.npmjs.com/package/fast-deep-equal
"
SRC_URI="https://registry.npmjs.org/fast-deep-equal/-/fast-deep-equal-3.1.3.tgz -> ${P}.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
