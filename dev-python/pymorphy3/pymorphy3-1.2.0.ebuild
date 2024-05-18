# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{10..12} pypy3  )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Morphological analyzer (POS tagger + inflection engine) for Russian language."
HOMEPAGE="https://github.com/no-plagiarism/pymorphy3 https://pypi.org/project/pymorphy3/"
DEPEND="
	dev-python/docopt[${PYTHON_USEDEP}]
	dev-python/pymorphy3-dicts-ru[${PYTHON_USEDEP}]
	dev-python/DAWG-Python[${PYTHON_USEDEP}]
"
RDEPEND="!dev-python/pymorphy2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
