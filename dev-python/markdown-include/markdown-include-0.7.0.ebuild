# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="Syntax which allows for inclusion of contents of other Markdown docs"
HOMEPAGE="https://github.com/cmacmackin/markdown-include"
SRC_URI="https://github.com/cmacmackin/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="0"

RDEPEND=">=dev-python/markdown-3.4[${PYTHON_USEDEP}]"

src_prepare() {
	sed -i "s/description-file/description_file/" setup.cfg || die
	distutils-r1_src_prepare
}
