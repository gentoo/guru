# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=uv-build
PYPI_VERIFY_REPO="stiermid/nnote"
inherit distutils-r1 pypi

DESCRIPTION="A plain, file-based note-taking CLI"
HOMEPAGE="
	https://stiermid.github.io/nnote/
	https://github.com/stiermid/nnote
	https://pypi.org/project/nnote/
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
"
