# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="A simple multilingual lemmatizer for Python"
HOMEPAGE="
	https://pypi.org/project/simplemma/
	https://github.com/adbar/simplemma
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

DOCS=( {HISTORY,README}.rst )

distutils_enable_tests pytest
