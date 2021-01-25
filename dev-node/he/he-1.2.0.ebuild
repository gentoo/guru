# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="A robust HTML entities encoder/decoder with full Unicode support."
HOMEPAGE="
	https://mths.be/he
	https://www.npmjs.com/package/he
"
SRC_URI="https://registry.npmjs.org/he/-/he-1.2.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
