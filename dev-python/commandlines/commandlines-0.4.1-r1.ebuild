# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} pypy3 )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Routines for extracting information from fontTools glyphs"
HOMEPAGE="
	https://commandlines.github.io
	https://pypi.org/project/commandlines/
	https://github.com/chrissimpkins/commandlines
"
SRC_URI="https://github.com/chrissimpkins/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
KEYWORDS="~amd64"
SLOT="0"

distutils_enable_tests pytest

distutils_enable_sphinx docs \
	dev-python/sphinx-rtd-theme
