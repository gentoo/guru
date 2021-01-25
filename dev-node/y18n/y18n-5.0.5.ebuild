# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="the bare-bones internationalization library used by yargs"
HOMEPAGE="
	https://github.com/yargs/y18n
	https://www.npmjs.com/package/y18n
"
SRC_URI="https://registry.npmjs.org/y18n/-/y18n-5.0.5.tgz"
LICENSE="ISC"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
