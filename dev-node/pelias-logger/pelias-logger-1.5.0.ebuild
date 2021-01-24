# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="The centralized logger package for Pelias."
HOMEPAGE="
	https://github.com/pelias/logger
	https://www.npmjs.com/package/pelias-logger
"
SRC_URI="https://registry.npmjs.org/pelias-logger/-/pelias-logger-1.5.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/winston
	dev-node/pelias-config
"
