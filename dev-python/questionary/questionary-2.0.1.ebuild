# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11..12} )

inherit distutils-r1

DESCRIPTION="Python library to build pretty command line user prompts"
HOMEPAGE="
	https://pypi.org/project/questionary/
	https://github.com/tmbo/questionary
"
SRC_URI="https://github.com/tmbo/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/prompt-toolkit[${PYTHON_USEDEP}]"

PATCHES=( "${FILESDIR}"/${PN}-2.0.1-prompt-toolkit.patch )

distutils_enable_tests pytest

distutils_enable_sphinx docs \
	dev-python/sphinx-autodoc-typehints \
	dev-python/sphinx-copybutton \
	dev-python/sphinx-rtd-theme
