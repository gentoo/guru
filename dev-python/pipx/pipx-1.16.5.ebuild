# Copyright 2023-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYPI_VERIFY_REPO=https://github.com/pypa/pipx
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Install and Run Python Applications in Isolated Environments"
HOMEPAGE="
	https://pipx.pypa.io/stable/
	https://pypi.org/project/pipx/
	https://github.com/pypa/pipx/
	"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/argcomplete-1.9.4[${PYTHON_USEDEP}]
	>=dev-python/filelock-3.16[${PYTHON_USEDEP}]
	>=dev-python/packaging-20.0[${PYTHON_USEDEP}]
	>=dev-python/platformdirs-4.6[${PYTHON_USEDEP}]
	>=dev-python/userpath-1.9.1[${PYTHON_USEDEP}]
	"
BDEPEND="
	>=dev-python/docutils-0.21[${PYTHON_USEDEP}]
	>=dev-python/hatch-vcs-0.4[${PYTHON_USEDEP}]
	"
