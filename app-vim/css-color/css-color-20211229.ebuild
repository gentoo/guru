# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit vim-plugin

COMMIT="8bf943681f92c81a8cca19762a1ccec8bc29098a"
DESCRIPTION="vim plugin: preview colours in source code while editing"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=5056
https://github.com/ap/vim-css-color"
SRC_URI="https://github.com/ap/vim-${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/vim-${PN}-${COMMIT}"

LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
