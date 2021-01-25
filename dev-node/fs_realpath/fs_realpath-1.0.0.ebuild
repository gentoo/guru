# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

MYPN="${PN/_/.}"
SRC_URI="https://registry.npmjs.org/${MYPN}/-/${MYPN}-${PV}.tgz -> ${P}.tgz"
DESCRIPTION="Use node's fs.realpath, but fall back to the JS implementation"
HOMEPAGE="
	https://github.com/isaacs/fs.realpath
	https://www.npmjs.com/package/fs.realpath
"
LICENSE="ISC"
KEYWORDS="~amd64"