# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
DISTUTILS_USE_SETUPTOOLS="pyproject.toml"

inherit distutils-r1

DESCRIPTION="Bash beautifier for the masses"
HOMEPAGE="https://github.com/lovesegfault/beautysh https://pypi.python.org/pypi/beautysh"
SRC_URI="https://github.com/lovesegfault/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64 ~x86 ~amd64-linux ~ppc-macos ~x64-macos ~x64-solaris ~x86-solaris"

LICENSE="GPL-2"
SLOT="0"

distutils_enable_tests pytest
