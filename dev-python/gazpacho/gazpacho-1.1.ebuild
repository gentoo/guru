# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="The simple, fast, and modern web scraping library"
HOMEPAGE="https://github.com/maxhumber/gazpacho https://pypi.org/project/gazpacho/"
SRC_URI="https://github.com/maxhumber/gazpacho/archive/refs/tags/v${PV}.tar.gz -> v${PV}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
DEPEND="${BDEPEND}"

PROPERTIES="test_network"
distutils_enable_tests pytest
