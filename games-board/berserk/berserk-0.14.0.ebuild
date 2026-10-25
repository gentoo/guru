# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_14 )

inherit distutils-r1 pypi

DESCRIPTION="Python client for the lichess API"
HOMEPAGE="https://github.com/lichess-org/berserk"
SRC_URI="https://github.com/lichess-org/berserk/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/deprecated[${PYTHON_USEDEP}]
	dev-python/ndjson
	dev-python/pydantic[${PYTHON_USEDEP}]
	dev-python/pyright
	dev-python/pytest-recording[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/requests-mock[${PYTHON_USEDEP}]
	dev-python/ruff[${PYTHON_USEDEP}]
	dev-python/sphinx[${PYTHON_USEDEP}]
	dev-python/sphinx-rtd-theme[${PYTHON_USEDEP}]
	dev-python/vcrpy[${PYTHON_USEDEP}]
	dev-python/watchdog[${PYTHON_USEDEP}]
"

RESTRICT="test"
