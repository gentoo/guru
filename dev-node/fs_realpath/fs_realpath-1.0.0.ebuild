# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Use node's fs.realpath, but fall back to the JS implementation if the native one fails"
HOMEPAGE="
	https://github.com/isaacs/fs.realpath
	https://www.npmjs.com/package/fs.realpath
"
SRC_URI="https://registry.npmjs.org/fs.realpath/-/fs.realpath-1.0.0.tgz"
LICENSE="ISC"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
MYPN="${PN/_/.}"
