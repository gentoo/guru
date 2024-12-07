# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="The sweeter pytest snapshot plugin"
HOMEPAGE="https://github.com/syrupy-project/syrupy https://pypi.org/project/syrupy"
SRC_URI="https://github.com/syrupy-project/syrupy/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DOCS=( README.md CHANGELOG.md )

RDEPEND="
	dev-python/rich[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/invoke[${PYTHON_USEDEP}]
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
