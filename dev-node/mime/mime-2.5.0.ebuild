# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="A comprehensive library for mime-type mapping"
HOMEPAGE="
	https://github.com/broofa/mime
	https://www.npmjs.com/package/mime
"
SRC_URI="https://registry.npmjs.org/mime/-/mime-2.5.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
