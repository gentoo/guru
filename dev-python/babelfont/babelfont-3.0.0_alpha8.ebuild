# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MYP="${P/_alpha/a}"
PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

DESCRIPTION="Interrogate and manipulate UFO, TTF and OTF fonts with a common interface"
HOMEPAGE="
	https://github.com/simoncozens/babelfont
	https://pypi.org/project/babelfont/
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${MYP}.tar.gz"
S="${WORKDIR}/${MYP}"

KEYWORDS="~amd64 ~x86"
LICENSE="MIT"
SLOT="0"

RDEPEND="
	dev-python/defcon[${PYTHON_USEDEP}]
	dev-python/fontParts[${PYTHON_USEDEP}]
	dev-python/fonttools[${PYTHON_USEDEP}]
	dev-python/glyphsLib[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

RESTRICT="test" # no tests in pypi release, pypi alpha releases untagged in github

distutils_enable_tests pytest
