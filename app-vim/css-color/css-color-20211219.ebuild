# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit vim-plugin

COMMIT="26ff274c20ef3929697ab31bbdeea5b42f890287"
DESCRIPTION="vim plugin: preview colours in source code while editing"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=5056
https://github.com/ap/vim-css-color"
SRC_URI="https://github.com/ap/vim-${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/vim-${PN}-${COMMIT}"

LICENSE="MIT"
KEYWORDS="~amd64 ~x86"

src_prepare() {
	default

	# avoid collision with other packages
	cd after/syntax || die
	for file in *.vim; do
		mkdir "${file%.vim}" || die
		mv "${file}" "${file%.vim}/${PN}.vim" || die
	done
}
