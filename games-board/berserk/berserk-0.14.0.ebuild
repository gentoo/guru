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
	dev-python/deprecated
	dev-python/ndjson
	dev-python/pydantic
	dev-python/pyright
	dev-python/pytest-recording
	dev-python/requests
	dev-python/requests-mock
	dev-python/ruff
	dev-python/sphinx
	dev-python/sphinx-rtd-theme
	dev-python/vcrpy
	dev-python/watchdog
"

RESTRICT="test"
