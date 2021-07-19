# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9} pypy3  )
DISTUTILS_USE_SETUPTOOLS=bdepend
inherit distutils-r1

DESCRIPTION="Morphological analyzer (POS tagger + inflection engine) for Russian language."
HOMEPAGE="https://github.com/kmike/pymorphy2 https://pypi.org/project/pymorphy2/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
DEPEND="
	dev-python/docopt[${PYTHON_USEDEP}]
	dev-python/pymorphy2-dicts-ru[${PYTHON_USEDEP}]
	dev-python/DAWG-Python[${PYTHON_USEDEP}]
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
