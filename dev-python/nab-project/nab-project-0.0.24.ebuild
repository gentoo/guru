# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_VERIFY_REPO=https://github.com/notatallshaw/nab
DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{13..15} )

inherit distutils-r1 pypi

DESCRIPTION="Indexed-backed provider, lockfile emitter, and downloader for nab"
HOMEPAGE="
	https://github.com/notatallshaw/nab/
	https://pypi.org/project/nab-project/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

# Many tests not working when not in monorepo
# in this  case it is better to just restrict
RESTRICT="test"

RDEPEND="
	dev-python/httpx2[${PYTHON_USEDEP}]
	dev-python/installer[${PYTHON_USEDEP}]
	~dev-python/nab-index-0.0.24[${PYTHON_USEDEP}]
	~dev-python/nab-markersets-0.0.24[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/pyproject-hooks[${PYTHON_USEDEP}]
	>=dev-python/tomli-2.5.0[${PYTHON_USEDEP}]
	>=dev-python/tomli-w-1.2.0[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
"

BDEPEND="
	dev-python/build[${PYTHON_USEDEP}]
	dev-python/hatch-vcs[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=( hypothesis respx )

distutils_enable_tests pytest
