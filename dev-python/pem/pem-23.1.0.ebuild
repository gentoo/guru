# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10..12} )
inherit distutils-r1 pypi

DESCRIPTION="Easy PEM file parsing in Python"
HOMEPAGE="https://pem.readthedocs.io/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=""
BDEPEND="
	dev-python/hatch-fancy-pypi-readme[${PYTHON_USEDEP}]
	test? (
		>=dev-python/coverage-5.0.2[${PYTHON_USEDEP}]
		dev-python/certifi[${PYTHON_USEDEP}]
		dev-python/pretend[${PYTHON_USEDEP}]
		dev-python/pyopenssl[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
