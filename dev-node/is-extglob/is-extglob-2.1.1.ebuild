# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="Returns true if a string has an extglob."
HOMEPAGE="
	https://github.com/jonschlinkert/is-extglob
	https://www.npmjs.com/package/is-extglob
"
SRC_URI="https://registry.npmjs.org/is-extglob/-/is-extglob-2.1.1.tgz -> ${P}.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
