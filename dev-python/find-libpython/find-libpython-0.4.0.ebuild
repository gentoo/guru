# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Finds the libpython associated with the current Python environment"
HOMEPAGE="https://github.com/ktbarrett/find_libpython"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~riscv ~x86"

# Tests can't work inside network sandbox
RESTRICT=test

PATCHES=(
	"${FILESDIR}/find-libpython-0.4.0-fix-license-qa.patch"
)
