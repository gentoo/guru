# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="A library for manipulating IPv4 and IPv6 addresses in JavaScript."
HOMEPAGE="
	https://github.com/whitequark/ipaddr.js
	https://www.npmjs.com/package/ipaddr.js
"

MYPN="${PN//_/.}"
SRC_URI="https://registry.npmjs.org/${MYPN}/-/${MYPN}-${PV}.tgz -> ${P}.tgz"

LICENSE="MIT"
KEYWORDS="~amd64"
