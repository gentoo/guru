# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit rakudo

DESCRIPTION="Command line tool for uploading distributions to zef ecosystem"
HOMEPAGE="https://github.com/tony-o/raku-fez"
SRC_URI="mirror://zef/F/EZ/FEZ/0b19dd84433b44730a15983296b72bd459f4b140.tar.gz -> ${P}.tar.gz"
LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="primaryuri"
DOCS="README.md"
S="${WORKDIR}/dist"

src_install() {
	rakudo_src_install
	rakudo_symlink_bin fez
}
