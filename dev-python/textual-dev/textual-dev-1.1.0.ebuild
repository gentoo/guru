# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

hash_commit="4e742d7cf4cdc7e2d8a9a768305fd9f7060b6b74"

DESCRIPTION="Modern Text User Interface framework"
HOMEPAGE="https://github.com/Textualize/textual-dev https://pypi.org/project/textual-dev/"
SRC_URI="https://github.com/Textualize/textual-dev/archive/${hash_commit}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-${hash_commit}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/aiohttp-3.8.1[${PYTHON_USEDEP}]
	>=dev-python/click-8.1.2[${PYTHON_USEDEP}]
	dev-python/importlib-metadata[${PYTHON_USEDEP}]
	>=dev-python/msgpack-1.0.3[${PYTHON_USEDEP}]
	dev-python/rich[${PYTHON_USEDEP}]
	>=dev-python/textual-0.32.0[${PYTHON_USEDEP}]
	=dev-python/typing-extensions-4*[${PYTHON_USEDEP}]
"

BDEPEND="
	test? (
		${RDEPEND}
		=dev-python/pytest-aiohttp-1*[${PYTHON_USEDEP}]
		=dev-python/time-machine-2*[${PYTHON_USEDEP}]
	)
"

DEPEND="${RDEPEND}"

distutils_enable_tests pytest
