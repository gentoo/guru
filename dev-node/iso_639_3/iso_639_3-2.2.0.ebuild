# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="ISO-639-3 codes in an accessible format"
HOMEPAGE="
	https://github.com/wooorm/iso-639-3
	https://www.npmjs.com/package/iso-639-3
"
SRC_URI="https://registry.npmjs.org/iso-639-3/-/iso-639-3-2.2.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
MYPN="${PN/_/-}"
