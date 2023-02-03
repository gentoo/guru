# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit rakudo

DESCRIPTION="A command line tool for renaming files in any text editor."
HOMEPAGE="https://codeberg.org/amano.kenji/raku-File-Name-Editor"
SRC_URI="mirror://zef/F/IL/FILE_NAME_EDITOR/553ab3efd41a7404684ca8c824efa8227791a8f7.tar.gz -> ${P}.tar.gz"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="primaryuri"
DOCS="README.md"
RDEPEND="dev-raku/File-Temp
	dev-raku/Term-termios"
DEPEND="${RDEPEND}"
S="${WORKDIR}/dist"

src_install() {
	rakudo_src_install
	rakudo_symlink_bin file-name-editor
}
