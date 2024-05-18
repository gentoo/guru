# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
inherit distutils-r1 pypi

DESCRIPTION="Ebook library which can handle EPUB2/EPUB3 and Kindle format"
HOMEPAGE="https://github.com/aerkalov/ebooklib https://pypi.org/project/EbookLib/"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
