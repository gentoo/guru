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
	dev-python/ndjson
	dev-python/pydantic
	dev-python/requests
	dev-python/deprecated
"
BDEPEND="
"
RESTRICT="test"
