# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="Command line admin tool for Synapse"
HOMEPAGE="https://github.com/JOJ0/synadm"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/click-option-group[${PYTHON_USEDEP}]
	dev-python/dnspython[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/tabulate[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
