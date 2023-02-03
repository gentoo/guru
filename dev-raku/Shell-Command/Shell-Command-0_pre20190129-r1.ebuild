# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit rakudo

COMMIT="1145ea0ff71507b2fe932fca6d2a68d4004c7d12"

DESCRIPTION="Cross-platform routines emulating common *NIX shell commands"
HOMEPAGE="https://github.com/tadzik/Shell-Command"
SRC_URI="https://github.com/tadzik/Shell-Command/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="primaryuri"
DOCS="README.md"
RDEPEND="dev-raku/File-Find
	dev-raku/File-Which"
DEPEND="${RDEPEND}"
S="${WORKDIR}/${PN}-${COMMIT}"
