# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="A cross platform Promise.allSettled polyfill"
HOMEPAGE="
	https://github.com/ungap/promise-all-settled
	https://www.npmjs.com/package/@ungap/promise-all-settled
"
SRC_URI="https://registry.npmjs.org/@ungap/promise-all-settled/-/promise-all-settled-1.1.2.tgz -> ${P}.tgz"
LICENSE="ISC"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
