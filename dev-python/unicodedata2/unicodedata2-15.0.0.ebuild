# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Unicodedata backport updated to the latest Unicode version"
HOMEPAGE="
	https://pypi.org/project/unicodedata2/
	https://github.com/mikekap/unicodedata2
"

KEYWORDS="~amd64"
LICENSE="Apache-2.0"
SLOT="0"

DOCS=( {CHANGELOG,README}.md )

distutils_enable_tests pytest
