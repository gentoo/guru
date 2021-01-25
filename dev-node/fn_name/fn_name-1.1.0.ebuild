# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

MYPN="${PN/_/.}"
SRC_URI="https://registry.npmjs.org/${MYPN}/-/${MYPN}-${PV}.tgz -> ${P}.tgz"
DESCRIPTION="Extract names from functions"
HOMEPAGE="
	https://github.com/3rd-Eden/fn.name
	https://www.npmjs.com/package/fn.name
"
LICENSE="MIT"
KEYWORDS="~amd64"