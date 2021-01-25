# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="Returns true if a number or string value is a finite number. Useful for regex matches, parsing, user input, etc."
HOMEPAGE="
	https://github.com/jonschlinkert/is-number
	https://www.npmjs.com/package/is-number
"
SRC_URI="https://registry.npmjs.org/is-number/-/is-number-7.0.0.tgz -> ${P}.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
