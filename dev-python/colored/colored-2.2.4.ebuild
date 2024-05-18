# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{10..12} pypy3 )

inherit distutils-r1

DESCRIPTION="Very simple Python library for color and formatting in terminal"
HOMEPAGE="https://gitlab.com/dslackw/colored"
SRC_URI="https://gitlab.com/dslackw/${PN}/-/archive/${PV}/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DOCS=( CHANGES.md README.rst docs )

# Until we find a way to set colored as unaware of TTY, we should not test as
# half of them fail, see https://gitlab.com/dslackw/colored/-/issues/32
# distutils_enable_tests pytest
