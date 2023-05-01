# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 pypi

DESCRIPTION="Syntax which allows for inclusion of contents of other Markdown docs"
HOMEPAGE="https://github.com/cmacmackin/markdown-include"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="0"
RESTRICT="!test? ( test )"

RDEPEND=">=dev-python/markdown-3.4[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

src_prepare() {
	sed -i "s/description-file/description_file/" setup.cfg || die
	distutils-r1_src_prepare
}
