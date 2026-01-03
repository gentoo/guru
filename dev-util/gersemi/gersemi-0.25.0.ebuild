# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="A formatter to make your CMake code the real treasure"
HOMEPAGE="https://github.com/BlankSpruce/gersemi"
SRC_URI="https://github.com/BlankSpruce/gersemi/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+color"

RDEPEND="
	dev-python/appdirs[${PYTHON_USEDEP}]
	dev-python/ignore-python[${PYTHON_USEDEP}]
	dev-python/lark[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]

	color? ( dev-python/colorama[${PYTHON_USEDEP}] )
"
BDEPEND="
	test? (
		dev-python/pydantic[${PYTHON_USEDEP}]
		dev-vcs/git
	)
"

distutils_enable_tests pytest
