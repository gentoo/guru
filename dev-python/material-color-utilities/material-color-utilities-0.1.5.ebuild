# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=poetry
PYPI_NO_NORMALIZE=1
PYPI_PN="${PN}-python"

inherit distutils-r1 pypi

MY_PN="${PN}-python"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python port of material-color-utilities used for Material You colors"
HOMEPAGE="
	https://pypi.org/project/material-color-utilities/
"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/avanishsubbiah/material-color-utilities-python.git"
else
	KEYWORDS="~amd64 ~arm64"
	S="${WORKDIR}/${MY_P}"
fi

LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/regex[${PYTHON_USEDEP}]"
BDEPEND="
	dev-python/poetry-core[${PYTHON_USEDEP}]
	dev-python/build[${PYTHON_USEDEP}]"
