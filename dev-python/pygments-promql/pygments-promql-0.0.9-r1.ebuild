# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="A PromQL lexer for Pygments"
HOMEPAGE="https://github.com/pabluk/pygments-promql"
SRC_URI="https://github.com/pabluk/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-python/pygments[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

distutils_enable_tests pytest
