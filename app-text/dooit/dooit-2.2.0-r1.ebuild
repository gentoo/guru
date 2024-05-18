# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="A TUI todo manager"
HOMEPAGE="https://github.com/kraanzu/dooit https://pipy.org/project/dooit"
SRC_URI="https://github.com/kraanzu/dooit/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/pyperclip-1.8.2[${PYTHON_USEDEP}]
	<dev-python/pyperclip-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-6.0[${PYTHON_USEDEP}]
	<dev-python/pyyaml-7.0[${PYTHON_USEDEP}]
	dev-python/tzlocal[${PYTHON_USEDEP}]
	>=dev-python/appdirs-1.4.4[${PYTHON_USEDEP}]
	<dev-python/appdirs-2.0.0[${PYTHON_USEDEP}]
	dev-python/textual[${PYTHON_USEDEP}]
	>=dev-python/python-dateutil-2.8.2[${PYTHON_USEDEP}]
	<dev-python/python-dateutil-3.0.0[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
