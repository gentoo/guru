# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1

DESCRIPTION="Modern Text User Interface framework"
HOMEPAGE="https://github.com/Textualize/textual https://pypi.org/project/textual"
SRC_URI="https://github.com/Textualize/textual/archive/refs/tags/v${PV}.tar.gz -> v${PV}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
# For the tests we would need many python modules not in any overlays I could find

RDEPEND="
	dev-python/rich[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-lang/python
	dev-python/poetry-core[${PYTHON_USEDEP}]
	dev-python/importlib_metadata[${PYTHON_USEDEP}]
"
DEPEND="
	${BDEPEND}
	${RDEPEND}
"

distutils_enable_tests pytest
