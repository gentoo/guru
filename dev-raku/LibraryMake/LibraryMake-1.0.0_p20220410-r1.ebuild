# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit rakudo

COMMIT="74fdf7154bf6b13713a5486a5aff9a3b649cb251"

DESCRIPTION="An attempt to simplify building native code for a Raku module."
HOMEPAGE="https://github.com/retupmoca/P6-LibraryMake"
SRC_URI="https://github.com/retupmoca/P6-LibraryMake/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="primaryuri"
DOCS="README.md"
RDEPEND="dev-raku/Shell-Command"
DEPEND="${RDEPEND}"
S="${WORKDIR}/P6-LibraryMake-${COMMIT}"
