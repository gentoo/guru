# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit vim-plugin

COMMIT="5687a7978bc80263cd03d0a667c2f56890cfb940"
DESCRIPTION="vim plugin: preview colours in source code while editing"
HOMEPAGE="
	https://github.com/ap/vim-css-color
	http://www.vim.org/scripts/script.php?script_id=5056
"
SRC_URI="https://github.com/ap/vim-${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/vim-${PN}-${COMMIT}"

LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
