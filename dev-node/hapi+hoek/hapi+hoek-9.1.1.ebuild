# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

first="${PN%%+*}"
second="${PN#*+}"
SRC_URI="https://registry.npmjs.org/@${first}/${second}/-/${second}.tgz -> ${P}.tgz"
DESCRIPTION="General purpose node utilities"
HOMEPAGE="
	https://github.com/hapijs/hoek
	https://www.npmjs.com/package/@hapi/hoek
"
LICENSE="BSD"
KEYWORDS="~amd64"