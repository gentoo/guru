# Copyright 2025
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_1{1..3} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1 pypi

DESCRIPTION="Typer, build great CLIs. Easy to code. Based on Python type hints."

HOMEPAGE="https://typer.tiangolo.com/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-python/shellingham[${PYTHON_USEDEP}]
	>=dev-python/click-8.0.0[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-3.7.4.3[${PYTHON_USEDEP}]
	dev-python/rich[${PYTHON_USEDEP}]
"

RDEPEND="${DEPEND}"
