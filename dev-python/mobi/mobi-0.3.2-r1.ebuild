# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
DISTUTILS_USE_PEP517=poetry
inherit distutils-r1

DESCRIPTION="unpack unencrypted mobi files"
HOMEPAGE="https://github.com/iscc/mobi https://pypi.org/project/mobi/"
SRC_URI="https://github.com/iscc/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}-r1.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/loguru[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
