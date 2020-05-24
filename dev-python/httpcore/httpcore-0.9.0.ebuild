# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )

DOCBUILDER="mkdocs"
DOCDEPEND="dev-python/mkdocs-material"
AUTODOC=1

inherit distutils-r1 docs

DESCRIPTION="A minimal HTTP client"
HOMEPAGE="
	https://github.com/encode/httpcore
	https://pypi.org/project/httpcore
"
SRC_URI="https://github.com/encode/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# Temporary failure in name resolution
# requires masked mitmproxy
RESTRICT="test"

RDEPEND="
	dev-python/h11[${PYTHON_USEDEP}]
	dev-python/hyper-h2[${PYTHON_USEDEP}]
	dev-python/sniffio[${PYTHON_USEDEP}]
	dev-python/trio[${PYTHON_USEDEP}]
"

DEPEND="
	${RDEPEND}
	test? (
		dev-python/autoflake[${PYTHON_USEDEP}]
		dev-python/black[${PYTHON_USEDEP}]
		dev-python/isort[${PYTHON_USEDEP}]
		dev-python/mypy[${PYTHON_USEDEP}]
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/pytest-trio[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
