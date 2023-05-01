# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} pypy3 )
DISTUTILS_USE_PEP517="flit"
inherit distutils-r1 pypi

DESCRIPTION="Transliterate Cyrillic to Latin in every possible way"
HOMEPAGE="
	https://dangry.ru/iuliia/
	https://pypi.org/project/iuliia/
	https://github.com/nalgeon/iuliia-py
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests pytest
