# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Sentence splitter using heuristic algorithm by Philipp Koehn and Josh Schroeder"
HOMEPAGE="
	https://pypi.org/project/sentence-splitter/
	https://github.com/mediacloud/sentence-splitter
"
SRC_URI="https://github.com/mediacloud/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND="dev-python/regex[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
