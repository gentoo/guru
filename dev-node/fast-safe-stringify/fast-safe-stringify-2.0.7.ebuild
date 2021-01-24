# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Safely and quickly serialize JavaScript objects"
HOMEPAGE="
	https://github.com/davidmarkclements/fast-safe-stringify
	https://www.npmjs.com/package/fast-safe-stringify
"
SRC_URI="https://registry.npmjs.org/fast-safe-stringify/-/fast-safe-stringify-2.0.7.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
