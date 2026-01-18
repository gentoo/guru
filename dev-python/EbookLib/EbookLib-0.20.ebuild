# Copyright 2021-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Ebook library which can handle EPUB2/EPUB3 and Kindle format"
HOMEPAGE="https://github.com/aerkalov/ebooklib https://pypi.org/project/EbookLib/"
# sdist doesn't include conftest.py
SRC_URI="https://github.com/aerkalov/ebooklib/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND="
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
