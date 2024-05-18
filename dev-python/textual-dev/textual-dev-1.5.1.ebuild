# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="Modern Text User Interface framework"
HOMEPAGE="https://github.com/Textualize/textual-dev https://pypi.org/project/textual-dev/"
SRC_URI="https://github.com/Textualize/textual-dev/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/textual-0.36.0[${PYTHON_USEDEP}]
	>=dev-python/aiohttp-3.8.1[${PYTHON_USEDEP}]
	>=dev-python/click-8.1.2[${PYTHON_USEDEP}]
	>=dev-python/msgpack-1.0.3[${PYTHON_USEDEP}]
	=dev-python/typing-extensions-4*[${PYTHON_USEDEP}]
"

BDEPEND="
	test? (
		${RDEPEND}
		dev-python/pytest-aiohttp[${PYTHON_USEDEP}]
		>=dev-python/time-machine-2.6.0[${PYTHON_USEDEP}]
		<dev-python/time-machine-3[${PYTHON_USEDEP}]
	)
"

DEPEND="${RDEPEND}"

distutils_enable_tests pytest
