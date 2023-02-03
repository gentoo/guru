# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit rakudo

COMMIT="89ad430ab08c78aa3c9181bb0b3020f1e2d01b32"

DESCRIPTION="Get a lazy list of a directory tree"
HOMEPAGE="https://github.com/tadzik/File-Find"
SRC_URI="https://github.com/tadzik/File-Find/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="primaryuri"
DOCS="README.md"
S="${WORKDIR}/${PN}-${COMMIT}"
