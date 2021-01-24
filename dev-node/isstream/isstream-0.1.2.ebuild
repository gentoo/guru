# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Determine if an object is a Stream"
HOMEPAGE="
	https://github.com/rvagg/isstream
	https://www.npmjs.com/package/isstream
"
SRC_URI="https://registry.npmjs.org/isstream/-/isstream-0.1.2.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
