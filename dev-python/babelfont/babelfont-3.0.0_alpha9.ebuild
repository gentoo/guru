# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
MYP="${P/_alpha/a}"
PYTHON_COMPAT=( python3_10 )

inherit distutils-r1

DESCRIPTION="Interrogate and manipulate UFO, TTF and OTF fonts with a common interface"
HOMEPAGE="
	https://github.com/simoncozens/babelfont
	https://pypi.org/project/babelfont/
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${MYP}.tar.gz"
S="${WORKDIR}/${MYP}"

KEYWORDS="~amd64"
LICENSE="MIT"
SLOT="0"

RDEPEND="
	>=dev-python/orjson-3.5.1[${PYTHON_USEDEP}]
	>=dev-python/fonttools-4.21.1[${PYTHON_USEDEP}]
	>=dev-python/ufoLib2-0.11.1[${PYTHON_USEDEP}]
	>=dev-python/openstep-plist-0.2.2[${PYTHON_USEDEP}]
	>=dev-python/glyphsLib-5.3.2[${PYTHON_USEDEP}]
	>=dev-python/glyphsLib-5.3.2[${PYTHON_USEDEP}]
	>=dev-python/cu2qu-1.6.7[${PYTHON_USEDEP}]
	dev-python/fontFeatures[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

RESTRICT="test" # no tests in pypi release, pypi alpha releases untagged in github

distutils_enable_tests pytest
