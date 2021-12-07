# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit vim-plugin

MY_PN="nim.vim"
COMMIT="a15714fea392b0f06ff2b282921a68c7033e39a2"
DESCRIPTION="vim plugin: nim language support"
HOMEPAGE="https://github.com/zah/nim.vim https://www.vim.org/scripts/script.php?script_id=2632"
SRC_URI="https://github.com/zah/${MY_PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${COMMIT}"

LICENSE="MIT"
KEYWORDS="~amd64"
