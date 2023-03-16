# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="A TUI todo manager"
HOMEPAGE="https://github.com/kraanzu/dooit https://pypi.org/project/dooit/"
SRC_URI="https://github.com/kraanzu/dooit/archive/refs/tags/v${PV}.tar.gz -> v${PV}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"

RDEPEND="
	dev-python/textual[${PYTHON_USEDEP}]
	dev-python/py-nanoid[${PYTHON_USEDEP}]
	dev-python/pyperclip[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/dateparser[${PYTHON_USEDEP}]
	dev-python/tzlocal[${PYTHON_USEDEP}]
	dev-python/appdirs[${PYTHON_USEDEP}]
"
DEPEND="${BDEPEND}"
