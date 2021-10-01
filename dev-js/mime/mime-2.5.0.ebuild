# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="A comprehensive library for mime-type mapping"
HOMEPAGE="
	https://github.com/broofa/mime
	https://www.npmjs.com/package/mime
"
SRC_URI="https://github.com/broofa/mime/archive/refs/tags/v${PV}.tar.gz -> ${P}.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
BDEPEND="
	${NODEJS_BDEPEND}
	dev-js/mime-score
	dev-js/runmd
	dev-js/supports-color
"
S="${WORKDIR}/${P}"
