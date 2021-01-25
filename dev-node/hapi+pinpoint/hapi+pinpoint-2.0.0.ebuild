# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Return the filename and line number of the calling function"
first="${PN%%+*}"
second="${PN#*+}"
SRC_URI="https://registry.npmjs.org/@${first}/${second}/-/${second}.tgz -> ${P}.tgz"
HOMEPAGE="
	https://github.com/hapijs/pinpoint
	https://www.npmjs.com/package/@hapi/pinpoint
"
LICENSE="BSD"
KEYWORDS="~amd64"