# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_VERIFY_REPO=https://github.com/notatallshaw/nab
DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 pypi

DESCRIPTION="PubGrub-based dependency resolver for Python packages"
HOMEPAGE="
	https://github.com/notatallshaw/nab/
	https://pypi.org/project/nab/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/httpx2[${PYTHON_USEDEP}]
	dev-python/nab-index[${PYTHON_USEDEP}]
	dev-python/nab-markersets[${PYTHON_USEDEP}]
	dev-python/nab-project[${PYTHON_USEDEP}]
	dev-python/nab-provider[${PYTHON_USEDEP}]
	dev-python/nab-resolver[${PYTHON_USEDEP}]
"

BDEPEND="
	dev-python/hatch-vcs[${PYTHON_USEDEP}]
"

# tests expect monorepo
RESTRICT="test"
