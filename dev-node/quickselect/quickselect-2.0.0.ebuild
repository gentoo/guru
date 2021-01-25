# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="A tiny and fast selection algorithm in JavaScript."
HOMEPAGE="
	https://www.npmjs.com/package/quickselect
"
SRC_URI="https://registry.npmjs.org/quickselect/-/quickselect-${PV}.tgz"
LICENSE="ISC"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
