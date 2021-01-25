# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="YAML 1.2 parser and serializer"
HOMEPAGE="
	https://github.com/nodeca/js-yaml
	https://www.npmjs.com/package/js-yaml
"
SRC_URI="https://registry.npmjs.org/js-yaml/-/js-yaml-4.0.0.tgz -> ${P}.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/argparse
"
