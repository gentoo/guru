# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit vim-plugin

COMMIT="a49f18d5f9676bd9064de25bfd3a1bfba898f177"

DESCRIPTION="MediaWiki syntax highlight; preview; interlinks autocompletion by coc.nvim"
HOMEPAGE="
	https://github.com/m-pilia/vim-mediawiki
"
SRC_URI="https://github.com/m-pilia/$PN/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="$WORKDIR/$PN-$COMMIT"

LICENSE="MIT"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/mwclient
"
