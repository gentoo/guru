# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

first="${PN%%+*}"
second="${PN#*+}"
SRC_URI="https://registry.npmjs.org/@${first}/${second}/-/${second}.tgz -> ${P}.tgz"
DESCRIPTION="A cross platform Promise.allSettled polyfill"
HOMEPAGE="
	https://github.com/ungap/promise-all-settled
	https://www.npmjs.com/package/@ungap/promise-all-settled
"
LICENSE="ISC"
KEYWORDS="~amd64"