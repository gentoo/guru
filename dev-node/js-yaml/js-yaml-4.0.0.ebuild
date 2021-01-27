# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="YAML 1.2 parser and serializer"
HOMEPAGE="
	https://github.com/nodeca/js-yaml
	https://www.npmjs.com/package/js-yaml
"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/argparse
"