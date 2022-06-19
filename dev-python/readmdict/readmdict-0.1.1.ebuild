# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
inherit distutils-r1

DESCRIPTION="Read mdx/mdd files"
HOMEPAGE="https://github.com/ffreemt/readmdict https://pypi.org/project/readmdict/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

DEPENDS="dev-python/python-lzo[${PYTHON_USEDEP}]"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
