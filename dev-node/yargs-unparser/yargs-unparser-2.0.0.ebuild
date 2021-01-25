# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="Converts back a yargs argv object to its original array form"
HOMEPAGE="
	https://github.com/yargs/yargs-unparser
	https://www.npmjs.com/package/yargs-unparser
"
SRC_URI="https://registry.npmjs.org/yargs-unparser/-/yargs-unparser-2.0.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/camelcase
	dev-node/decamelize
	dev-node/flat
	dev-node/is-plain-obj
"
