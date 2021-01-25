# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

first="${PN%%+*}"
second="${PN#*+}"
SRC_URI="https://registry.npmjs.org/@${first}/${second}/-/${second}.tgz -> ${P}.tgz"
DESCRIPTION="Math and string formula parser."
HOMEPAGE="
	https://github.com/hapijs/formula
	https://www.npmjs.com/package/@hapi/formula
"
LICENSE="BSD"
KEYWORDS="~amd64"