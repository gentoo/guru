# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="Plugin to check import ordering using isort"
HOMEPAGE="https://github.com/stephrdev/pytest-isort"
SRC_URI="https://github.com/stephrdev/pytest-isort/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
SLOT="0"

distutils_enable_tests pytest

RDEPEND="
	dev-python/pytest[${PYTHON_USEDEP}]
	dev-python/isort[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/stray-files.patch"
)
