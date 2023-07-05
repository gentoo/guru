# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11,12} )

inherit distutils-r1

DESCRIPTION="A library to parse gdb mi output and interact with gdb subprocesses"
HOMEPAGE="https://github.com/cs01/pygdbmi"
SRC_URI="https://github.com/cs01/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=""
DEPEND="${RDEPEND}"

distutils_enable_tests pytest
