# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} pypy3 )
DISTUTILS_USE_SETUPTOOLS="pyproject.toml"
inherit distutils-r1

DESCRIPTION="Transliterate Cyrillic to Latin in every possible way"
HOMEPAGE="
	https://dangry.ru/iuliia/
	https://pypi.org/project/iuliia/
	https://github.com/nalgeon/iuliia-py
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests pytest
