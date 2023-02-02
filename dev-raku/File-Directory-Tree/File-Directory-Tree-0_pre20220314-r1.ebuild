# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit rakudo

COMMIT="e386a00ecdd5a149c888257feb1715c8825d8545"

DESCRIPTION="Module for creating and deleting directories"
HOMEPAGE="https://raku.land/github:labster/File::Directory::Tree"
SRC_URI="https://github.com/labster/p6-file-directory-tree/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="primaryuri"
DOCS="README.md"
S="${WORKDIR}/p6-file-directory-tree-${COMMIT}"
